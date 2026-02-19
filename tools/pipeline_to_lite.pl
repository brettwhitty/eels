#!/usr/bin/env perl
use strict;
use warnings;
use JSON;
use File::Slurp;
use File::Basename;

my $input = shift or die "Usage: $0 <pipeline.json>\n";
my $data = from_json(read_file($input));

my $name = $data->{name} || basename($input, '.json');
print "# $name\n";
print node_to_lite($data->{structure}, 0), "\n";

sub node_to_lite {
    my ($node, $depth) = @_;
    my $indent = "    " x $depth;
    
    if ($node->{type} && $node->{type} eq 'component') {
        return "${indent}<$node->{id}>";
    }
    
    my $children = $node->{children} || [];
    return "" unless @$children;
    
    # Determine bracket type from node type
    my $open  = '(';
    my $close = ')';
    if ($node->{type} && $node->{type} eq 'parallel') {
        $open  = '{';
        $close = '}';
    }
    
    my @parts;
    for my $child (@$children) {
        push @parts, node_to_lite($child, $depth + 1);
    }
    
    return "${indent}${open}\n" . join(",\n", @parts) . "\n${indent}${close}";
}
