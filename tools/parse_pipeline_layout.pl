#!/usr/bin/env perl

use strict;
use warnings;
use JSON::PP;
use File::Basename;
use File::Spec::Functions;

my $pipelines_dir = $ARGV[0] or die "Usage: $0 <pipelines_dir> <output_dir>\n";
my $output_dir = $ARGV[1] or die "Usage: $0 <pipelines_dir> <output_dir>\n";

my $json = JSON::PP->new->utf8->pretty->canonical;

opendir(my $dh, $pipelines_dir) or die "Can't open $pipelines_dir: $!";
my @pipeline_dirs = sort grep { -d catfile($pipelines_dir, $_) && $_ !~ /^\./ } readdir($dh);
closedir($dh);

foreach my $pipeline_name (@pipeline_dirs) {
    my $pipeline_path = catfile($pipelines_dir, $pipeline_name);
    my $layout_file = catfile($pipeline_path, 'pipeline.layout');
    
    my $pipeline = {
        name => $pipeline_name,
        has_layout => (-f $layout_file) ? JSON::PP::true : JSON::PP::false,
        components => [],
        component_configs => {},
    };
    
    if (-f $layout_file) {
        my $xml = slurp($layout_file);
        $pipeline->{structure} = parse_xml($xml);
        my @ids;
        extract_components($pipeline->{structure}, \@ids);
        $pipeline->{components} = \@ids;
    }
    
    # Catalog component configs
    opendir(my $pdh, $pipeline_path) or next;
    my @configs = sort grep { /\.config$/ && $_ ne 'pipeline.config' } readdir($pdh);
    closedir($pdh);
    
    foreach my $config_file (@configs) {
        my $basename = $config_file;
        $basename =~ s/\.config$//;
        my ($component, $token);
        if ($basename =~ /^([^.]+)\.(.+)$/) {
            ($component, $token) = ($1, $2);
        } else {
            $component = $basename;
            $token = 'default';
        }
        $pipeline->{component_configs}{$basename} = {
            component => $component,
            token => $token,
        };
    }
    
    my $pipeline_config = catfile($pipeline_path, 'pipeline.config');
    if (-f $pipeline_config) {
        $pipeline->{has_pipeline_config} = JSON::PP::true;
        $pipeline->{pipeline_config} = parse_ini($pipeline_config);
    } else {
        $pipeline->{has_pipeline_config} = JSON::PP::false;
    }
    
    my $output_file = catfile($output_dir, "$pipeline_name.json");
    open(my $fh, '>', $output_file) or die "Can't write $output_file: $!";
    print $fh $json->encode($pipeline);
    close($fh);
    
    my $n = scalar @{$pipeline->{components}};
    my $nc = scalar @configs;
    print STDERR "  $pipeline_name: $n components, $nc configs\n";
}

sub parse_xml {
    my ($xml) = @_;
    # Simple recursive descent parser for pipeline.layout
    # Structure: commandSetRoot > commandSet (serial/parallel) > ...
    # Leaf commandSets contain <name>component.token</name> and no child commandSets
    
    pos($xml) = 0;
    my $tree = _parse_element(\$xml);
    return $tree;
}

sub _parse_element {
    my ($xml_ref) = @_;
    
    # Skip whitespace
    $$xml_ref =~ /\G\s*/gc;
    
    # Match opening tag
    if ($$xml_ref =~ /\G<(commandSetRoot|commandSet)([^>]*)>/gc) {
        my ($tag, $attrs) = ($1, $2);
        my $node = { _tag => $tag, children => [] };
        
        if ($attrs =~ /type\s*=\s*"([^"]+)"/) {
            $node->{type} = $1;
        }
        
        # Parse children
        while (1) {
            $$xml_ref =~ /\G\s*/gc;
            
            # Check for closing tag
            if ($$xml_ref =~ /\G<\/$tag>/gc) {
                last;
            }
            # Check for child elements
            elsif ($$xml_ref =~ /\G<(state|name)>([^<]*)<\/\1>/gc) {
                $node->{$1} = $2;
            }
            elsif ($$xml_ref =~ /\G(?=<commandSet)/gc) {
                my $child = _parse_element($xml_ref);
                push @{$node->{children}}, $child if $child;
            }
            elsif ($$xml_ref =~ /\G</gc) {
                # skip unknown tags
                $$xml_ref =~ /\G[^>]*>/gc;
            }
            elsif ($$xml_ref =~ /\G[^<]+/gc) {
                # skip text
            }
            else {
                last; # safety
            }
        }
        
        # Determine if this is a leaf (component reference) or a branch
        if (@{$node->{children}} == 0 && defined $node->{name}) {
            # Leaf commandSet = component reference
            return { type => 'component', id => $node->{name} };
        }
        
        # Clean up - only keep relevant fields
        my $result = { type => $node->{type} // 'serial', children => $node->{children} };
        $result->{name} = $node->{name} if defined $node->{name};
        return $result;
    }
    
    return undef;
}

sub extract_components {
    my ($node, $list) = @_;
    return unless ref $node eq 'HASH';
    if (($node->{type} // '') eq 'component') {
        push @$list, $node->{id};
    }
    if ($node->{children}) {
        for my $child (@{$node->{children}}) {
            extract_components($child, $list);
        }
    }
}

sub parse_ini {
    my ($file) = @_;
    open(my $fh, '<', $file) or return {};
    my $config = {};
    my $section = '_global';
    while (my $line = <$fh>) {
        chomp $line;
        next if $line =~ /^\s*[;#]/;
        next if $line =~ /^\s*$/;
        if ($line =~ /^\s*\[([^\]]+)\]\s*$/) {
            $section = $1;
        } elsif ($line =~ /^\s*(\S+)\s*=\s*(.*?)\s*$/) {
            $config->{$section}{$1} = $2;
        }
    }
    close($fh);
    return $config;
}

sub slurp {
    my ($file) = @_;
    open(my $fh, '<', $file) or die "Can't read $file: $!";
    local $/;
    my $content = <$fh>;
    close($fh);
    return $content;
}
