#!/usr/bin/env perl
use strict;
use warnings;
use JSON;

use File::Basename;

my $input = shift or die "Usage: $0 <pipeline.json>\n";
my $data = do { open my $fh, "<", $input or die "$!"; local $/; decode_json(<$fh>) };

my $name = $data->{name} || basename($input, '.json');
print "# $name\n";

# Unwrap top-level container (type=instance or bare serial wrapper)
my $structure = $data->{structure};
while ($structure->{children} 
       && @{$structure->{children}} == 1
       && ref($structure->{children}[0]) eq 'HASH'
       && $structure->{children}[0]{children}
       && ($structure->{type} || '') ne 'parallel') {
    $structure = $structure->{children}[0];
}

print node_to_lite($structure, 0), "\n";

sub node_to_lite {
    my ($node, $depth) = @_;
    my $indent = "    " x $depth;
    
    if ($node->{type} && $node->{type} eq 'component') {
        return "${indent}<$node->{id}>";
    }
    
    my $children = $node->{children} || [];
    return "" unless @$children;
    
    # Trim unnecessary nesting: serial with single serial child, or parallel with single parallel child
    while (@$children == 1 
           && ref($children->[0]) eq 'HASH' 
           && ($children->[0]{type} || '') eq ($node->{type} || '')
           && $children->[0]{children}) {
        $children = $children->[0]{children};
    }
    
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
