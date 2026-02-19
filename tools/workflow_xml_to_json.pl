#!/usr/bin/env perl

use strict;
use warnings;

use Carp;
use JSON;
use XML::XML2JSON;
use File::Slurp;
use Getopt::Long;
use File::Basename qw{ dirname basename };
use File::Spec::Functions;
use Cwd qw{ abs_path };


### NEED TO READ IN THE COMPONENT.CONFIG FILE
### AND DO A REPLACE OF THE VALUES
### ***ESPECIALLY TO CORRECTLY INCLUDE THE INTERATOR TEMPLATES XML***
### ITERATOR TEMPLATE VARIABLES (EG: ITERATOR_NAME)
### ARE USED IN PROCESSING THE ITERATOR TEMPLATES (eg: COMPONENT.i1.xml)

use Data::Dumper;

my $input;
GetOptions(
    'input|i=s' =>  \$input,
);

unless (defined($input) && -f $input) {
    die "Must provide an XML input file that exists with --input flag!";
}

my $converter = XML::XML2JSON->new( module => 'JSON', force_array => 0, attribute_prefix => '_');

my $component_xml_file = abs_path($input);
my $component_xml_basename = basename($component_xml_file);

## for preparing config file name
my $component_name = $component_xml_basename;
$component_name =~ s/^([^.]+).*$/$1/;

my $docs_dir = dirname($component_xml_file);

## component config path
my $component_config_file = catfile($docs_dir, $component_name.'.config');

my $component_config = parse_component_config_file($component_config_file);

my $component_xml = read_file($input);

## take care of 'INCLUDE' elements
do_xml_include(\$component_xml);

#$xml = add_idx_atts($xml);
$component_xml = insert_idx_atts($component_xml);

reformat_var_syntax_to_handlebars(\$component_xml);
#print $xml;

my @var_names = get_var_names(\$component_xml);

#print $xml;

## convert to JSON
my $json = $converter->convert($component_xml);

## convert back to object
my $o = from_json($json);

## do some cleanup
$o->{'commandSetRoot'}->{'commandSet'} = $o->{'commandSetRoot'}->{'i0-commandSet'};
delete $o->{'commandSetRoot'}->{'i0-commandSet'};
delete $o->{'_version'};
delete $o->{'_encoding'};
delete $o->{'commandSetRoot'}->{'_xmlns:xsi'};
delete $o->{'commandSetRoot'}->{'_xsi:schemaLocation'};

assign_element_values($o);

#commandset_to_array($o->{'commandSetRoot'});
#commandset_to_array($o);

##commandset_create_members_array($o->{'commandSetRoot'}->{'c1001-commandSet'});
#recurse_commandset($o->{'commandSetRoot'});
recurse_commandset($o);

print to_json($o, {utf8 => 1, pretty => 1});

sub insert_idx_atts {
    my ($xml) = @_;

    ## we're converting to JSON so will lose the ordering of the elements
    ## in the XML file; maitain this info by adding an attribute 'id' to
    ## 'commandSet' and child 'command' elements

    my @arr = split(/</, $xml);

    my $num = scalar @arr;

    my $cur_idx = [];
    my $cur_idx_counts = {};
    my $LINE_COUNT = 0;
    for (my $i = 0; $i < $num; $i++) {
        ++$LINE_COUNT;
        if ($arr[$i] =~ /^commandSet[\>\s]+?/) {
            #print "START commandSet (LINE = $LINE_COUNT)\n";
            my $idx_val = start_idx_element($cur_idx, $cur_idx_counts);

            $arr[$i] =~ s/^commandSet(\s*)/i$idx_val-commandSet$1/;

        } elsif ($arr[$i] =~ /^\/commandSet[\>\s]+?/) {
            #print "END commandSet (LINE = $LINE_COUNT)\n";
       
            my $idx_val = end_idx_element($cur_idx, $cur_idx_counts);
        
            $arr[$i] =~ s/^\/commandSet(\s*?\>)/\/i$idx_val-commandSet$1/;

        } elsif ($arr[$i] =~ /^command[\>\s]+?/) {
            #print "START command (LINE = $LINE_COUNT)\n";
            my $idx_val = start_idx_element($cur_idx, $cur_idx_counts);
           
            $arr[$i] =~ s/^command(\s*\>)/i$idx_val-command$1/;

        } elsif ($arr[$i] =~ /^\/command[\s\>]+?/) {
            #print "END command (LINE = $LINE_COUNT)\n";
             my $idx_val = end_idx_element($cur_idx, $cur_idx_counts);

            $arr[$i] =~ s/^\/command(\s*\>)/\/i$idx_val-command$1/;
        }
    }

    return join('<', @arr);
}

sub do_xml_include {
    my ($xml_ref) = @_;

    my $includes = {};
    while (${$xml_ref} =~ /(\<\s*INCLUDE \s*([^>]+)\s*[\/]*\>)/gs) {
        my ($include_element_string, $atts_string) = ($1, $2);

        ## this is a lazy hack
        $atts_string =~ s/\/$//;

        unless ($include_element_string =~ /\/\>/) {
            warn "WARNING: Malformed INCLUDE element in input XML.";
        }

        my @att_strings = split(/\s+/, $atts_string);

        my $atts = {};
        my $elem_atts = {};
        foreach my $att_string(@att_strings) {

            my ($key, $value) = split(/=/, $att_string, 2);

            $value =~ s/^[\"\']|[\"\']$//g;
        
            $atts->{$key} = $value;
        }
        if (defined($atts->{'keys'})) {
            my @key_strings = split(/,/, $atts->{'keys'});

            my $keys = {};

            foreach my $key_string(@key_strings) {
                my ($key, $val) = split(/=/, $key_string);

                $keys->{$key} = $val;

                my $elem_att = $key;
                $elem_att =~ s/^\$\;([^\$]+)\$\;$/$1/;
                #$elem_att = "{{$elem_att}}";
                
                $elem_atts->{$elem_att} = $val;
            }

            $atts->{'keys'} = $keys;

        }
    
        do_variable_replacement($atts, { 'docs_dir' => $docs_dir});
    
        if (! -f $atts->{'file'}) {
            my $include_file = $atts->{'file'};

            ## see if the file is in a subdir called includes
            my $inc_file_dir = dirname($include_file);
            my $inc_file_basename = basename($include_file);
            $include_file = $inc_file_dir.'/includes/'.$inc_file_basename;

            if (-f $include_file) {
                $atts->{'file'} = $include_file;
            } else {
                croak "Missing include file '$atts->{file}'!";
            }
        }

        my $xml_include = read_file($atts->{'file'});
        
        do_xml_variable_replacement(\$xml_include, $atts->{'keys'});
        
        ## nested includes are allowed so handle them here 
        while ($xml_include =~ /\<INCLUDE /) {
            do_xml_include(\$xml_include);
        }

#        my $include_head = "<include type=\"_include\">\n";
#        foreach my $key(keys %{$elem_atts}) {
#            $include_head .= "  <param>\n";
#            $include_head .= "    <key>$key</key>\n";
#            $include_head .= "    <value>$elem_atts->{$key}</value>\n";
#            $include_head .= "  </param>\n";
#        }

#        my $include_foot = "</include>\n";
        
        #$includes->{$include_element_string} = $include_head . $xml_include . $include_foot;
        $includes->{$include_element_string} = $xml_include;
    }

    foreach my $element(keys %{$includes}) {
        ${$xml_ref} =~ s/\Q$element\E/$includes->{$element}/;
    }
}

sub do_xml_variable_replacement {
    my ($xml_ref, $vals_hash_ref) = @_;

    foreach my $key(keys %{$vals_hash_ref}) {
        ## \Q \E are necessary here to escape '$;' on the match side
        ${$xml_ref} =~ s/\Q$key\E/$vals_hash_ref->{$key}/g;
    }
}

sub do_variable_replacement {
    my ($target_hash_ref, $src_hash_ref) = @_;

    ## iterate through the values in $target_hash_ref
    ## match on $;[SRC_HASH_REF_KEY]$; and replace with its value

    foreach my $t_key(keys %{$target_hash_ref}) {
        my $value = $target_hash_ref->{$t_key};
        my $new_value = $value;

        while ($value =~ /\$;([^\$]+)\$;/g) {
            my $var = $1;
            my $key = lc($var);

            if (defined($src_hash_ref->{$key})) {
                $new_value =~ s/\$;$var\$;/$src_hash_ref->{$key}/g;
            }
        }
        $target_hash_ref->{$t_key} = $new_value;
    }
}

sub start_idx_element {
    my ($idx_ref, $counts_ref) = @_;

    my $parent_idx_val = undef;
    
    if (scalar @{$idx_ref} == 0) {
        $parent_idx_val = '_ROOT_';
    } else {
        $parent_idx_val = idx_to_string($idx_ref);
    }

    if (! defined($counts_ref->{$parent_idx_val})) {
        $counts_ref->{$parent_idx_val} = 999;
    }
    ++$counts_ref->{$parent_idx_val};

    ## use stack to keep track of current parent element
    push(@{$idx_ref}, $counts_ref->{$parent_idx_val});
           
    my $idx_val = idx_to_string($idx_ref);

    return $idx_val;
}

sub end_idx_element {
    my ($idx_ref) = @_;
    
    my $idx_val = idx_to_string($idx_ref);

    pop(@{$idx_ref});

    return $idx_val;
}

sub reformat_var_syntax_to_handlebars {
    my ($string_ref) = @_;

    ${$string_ref} =~ s/\$\;([^\$]+)\$\;/{{$1}}/g;
}

sub get_var_names {
    my ($xml_ref) = @_;

    my $names = {};
    while (${$xml_ref} =~ /\{\{([^}]+)\}\}/g) {
        $names->{$1} = 1;
    }

    return sort keys %{$names};
}

sub assign_element_values {
    my ($ref) = @_;
   
    if (ref($ref) eq 'HASH') {
    
        my @children_keys = keys %{$ref};

        foreach my $child_key(@children_keys) {

            my $child = $ref->{$child_key};
            #if (scalar @children_keys == 1)  {
            #my $child = $ref->{$children_keys[0]};
               
            if (ref($child) eq 'HASH') {
            
                my @child_keys = keys %{$child};
            
                if (scalar(@child_keys) == 1 && $child_keys[0] eq '$t') {
                    ## found a leaf
                    $ref->{$child_key} = $child->{'$t'};
                } else {
                    assign_element_values($child);
                }
            } elsif (ref($child) eq 'ARRAY') {
                assign_element_values($child);
            }
            #  } else {
            # foreach my $key(@children_keys) {
            #    print "ITER $key\n";
            #    assign_element_values($ref->{$key});
            #}
        }
    } elsif (ref($ref) eq 'ARRAY') {
        foreach my $val(@{$ref}) {
            assign_element_values($val);
        }
    }
}

sub idx_to_string {
    my ($idx_ref) = @_;

    my @vals = (@{$idx_ref});
    $vals[0] -= 1000;

    return join('.', @vals);
}

sub commandset_to_array {
    my ($ref) = @_;

    my @keys = sort keys %{$ref};

    #print Dumper \@keys;

    my $commands = [];
    foreach my $key(@keys) {
        #print "$key\n";
        if ($key =~ /-(command(Set)?)$/) {
            my $type = $1;
            
            push(@{$commands}, {$type => $ref->{$key}});
                
            delete $ref->{$key};
           
        }
    }
    $ref->{'commands'} = $commands;
}

sub commandset_create_members_array {
    my ($cs_ref) = (@_);

    my @keys = %{$cs_ref};

    $cs_ref->{'_members'} = [];

    my $member_idx = -1;
    foreach my $key(sort @keys) {
        if ($key =~ /^(i[0-9.]+)-(command(Set)?)/) {
            my ($idx, $type) = ($1, $2);
            #print "$key $1\n";
            my $member = {
                '_idx'  =>  ++$member_idx,
                '_type' =>  $type,
                $type   =>  $cs_ref->{$key},
            };
            push(@{$cs_ref->{'_members'}}, $member);
            delete $cs_ref->{$key};
        }
    }
}

sub recurse_commandset {
    my ($ref) = @_;

    if (ref($ref) eq 'HASH') {
       my @keys = keys %{$ref};

       foreach my $key(sort @keys) {
           if ($key =~ /(i[0-9.]+-)?commandSet$/) {
                commandset_create_members_array($ref->{$key});
           }
           #} else {
               recurse_commandset($ref->{$key});
               #}
       }
   } elsif (ref($ref) eq 'ARRAY') {
       foreach my $item(@{$ref}) {
           recurse_commandset($item);
       }
   }
}

sub parse_component_config_file {
    my ($component_config_file) = @_;

    open my $infh, '<', $component_config_file
        or die "Unable to open component config file '$component_config_file' for reading: $!";

    my $cc = {};
    my $ref = undef;
    my @comments = ();
    my $last = undef;
    while (my $line = <$infh>) {
        chomp $line; 
        
        if ($line =~ /^\s*\[([^\]]+)\]\s*$/) {
            @comments = ();
            my $section_text = $1;
            
            ## trim any extra spaces (shouldn't happen but who knows)
            $section_text =~ s/^\s+|\s+$//g;
            ## replace space in section names with '.', which is per ini files spec
            $section_text =~ s/\s+/./g;
           
            my @section_tokens = split(/\./, $section_text);

            $ref = $cc;
            foreach my $key(@section_tokens) {
                if (! defined($ref->{$key})) {
                    $ref->{$key} = {};
                }
                $ref = $ref->{$key};
            }
            $last = 'section_header';
        } elsif ($line =~ /^\s*[;]+\s*(.*)$/) {
            my $comment = $1;
            if ($last ne 'comment') { 
                @comments = ();
            } 
            push(@comments, $comment);
            $last = 'comment';
        } elsif ($line =~ /^\s*(\S+)\s*=\s*(.*)\s*$/) {
            my ($key, $value) = ($1, $2);
           
            my $obj_key = safe_key($key);

            if (scalar @comments > 0) {
                $ref->{$obj_key}->{'_comments'} = [@comments];
            }
            $ref->{$obj_key}->{'token'}   = $key;
            $ref->{$obj_key}->{'value'} = $value;
            $last = 'key_value';
        } elsif ($line =~ /^\s*$/) {
            @comments = ();
            $last = 'empty';
        }
    }

    close $infh;

    return $cc;
}

sub safe_key {
    my ($key) = @_;

    $key =~ s/^\$;(.*)\$;$/{{$1}}/;

    return $key;
}

sub unsafe_key {
    my ($key) = @_;

    $key =~ s/^{{(.*)}}$/\$;$1\$;/;

    return $key;
}
