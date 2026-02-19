#!/usr/bin/env perl

use strict;
use warnings;
use JSON;
use File::Slurp;
use File::Basename;
use Getopt::Long;

my $input;
my $output;

GetOptions(
    'input|i=s'  => \$input,
    'output|o=s' => \$output,
);

die "Provide --input JSON file\n" unless defined($input) && -f $input;

my $json_text = read_file($input);
my $o = from_json($json_text);

my $component_name = basename($input);
$component_name =~ s/^([^.]+).*$/$1/;

# Categorization rules based on executable patterns
my %categories = (
    # Infrastructure
    'mkdir'                     => 'infrastructure',
    'create_iterator_groups'    => 'infrastructure',
    'replace_template_keys'     => 'infrastructure',
    'create_file_iterator_list' => 'infrastructure',
    'create_list_file'          => 'infrastructure',
    
    # Provenance
    'analysis2bsml'             => 'provenance',
    
    # Compression
    'compress_file'             => 'compression',
    
    # Validation
    'dtdValid.pl'               => 'validation',
);

# Converter patterns (executable contains "2bsml", "2btab", "2gff3", etc.)
my @converter_patterns = (
    qr/2bsml$/,
    qr/2btab$/,
    qr/2gff3$/,
    qr/2chado$/,
    qr/2fasta$/,
    qr/2genbank$/,
    qr/^bsml2/,
    qr/^blast2/,
);

categorize_node($o);

my $result = {
    component => $component_name,
    source_file => basename($input),
    steps => extract_categorized_steps($o),
};

my $json_out = to_json($result, { utf8 => 1, pretty => 1, canonical => 1 });

if (defined $output) {
    open(my $fh, '>', $output) or die "Can't write $output: $!";
    print $fh $json_out;
    close($fh);
} else {
    print $json_out;
}

sub categorize_node {
    my ($ref) = @_;
    
    if (ref($ref) eq 'HASH') {
        if (exists $ref->{'command'}) {
            my $cmd = $ref->{'command'};
            my $exec = $cmd->{'executable'} || '';
            my $exec_base = basename($exec);
            $exec_base =~ s/\{\{[^}]+\}\}\/?//g;  # strip handlebars paths
            
            my $category = classify_executable($exec_base, $cmd->{'name'} || '');
            $cmd->{'_category'} = $category;
        }
        
        if (exists $ref->{'_members'}) {
            for my $member (@{$ref->{'_members'}}) {
                categorize_node($member);
            }
        }
        
        for my $key (keys %$ref) {
            categorize_node($ref->{$key}) if ref($ref->{$key});
        }
    } elsif (ref($ref) eq 'ARRAY') {
        for my $item (@$ref) {
            categorize_node($item);
        }
    }
}

sub classify_executable {
    my ($exec_base, $name) = @_;
    
    # Check exact matches first
    return $categories{$exec_base} if exists $categories{$exec_base};
    
    # Check converter patterns
    for my $pattern (@converter_patterns) {
        return 'converter' if $exec_base =~ $pattern;
    }
    
    # Check name-based patterns
    return 'infrastructure' if $name =~ /^create (output|temp) directory$/i;
    return 'infrastructure' if $name =~ /create.*list/i;
    return 'infrastructure' if $name =~ /create.*iterator/i;
    return 'infrastructure' if $name =~ /replace.*template/i;
    
    # Default: tool_execution
    return 'tool_execution';
}

sub extract_categorized_steps {
    my ($ref) = @_;
    my @steps;
    _extract_steps($ref, \@steps);
    return \@steps;
}

sub _extract_steps {
    my ($ref, $list) = @_;
    
    if (ref($ref) eq 'HASH') {
        if (exists $ref->{'command'} && ref($ref->{'command'}) eq 'HASH') {
            my $cmd = $ref->{'command'};
            push @$list, {
                name       => $cmd->{'name'} || 'unnamed',
                executable => $cmd->{'executable'} || '',
                category   => $cmd->{'_category'} || 'unknown',
                idx        => $ref->{'_idx'},
            };
        }
        
        if (exists $ref->{'_members'}) {
            for my $member (@{$ref->{'_members'}}) {
                _extract_steps($member, $list);
            }
        }
        
        for my $key (sort keys %$ref) {
            next if $key eq '_members' || $key eq 'command';
            _extract_steps($ref->{$key}, $list) if ref($ref->{$key});
        }
    } elsif (ref($ref) eq 'ARRAY') {
        for my $item (@$ref) {
            _extract_steps($item, $list);
        }
    }
}
