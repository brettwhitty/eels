#!/usr/bin/env perl

use strict;
use warnings;

use JSON::PP;
use File::Basename;
use Getopt::Long;

my $input = undef;
my $output = undef;
my $nf_dir = undef;

GetOptions(
    'input|i=s'  => \$input,
    'output|o=s' => \$output,
    'nf-dir|n=s' => \$nf_dir,
);

unless (defined($input) && -f $input) {
    die "Provide pipeline JSON with --input\n";
}

open(my $fh, '<', $input) or die "Can't read $input: $!";
local $/;
my $json_text = <$fh>;
close($fh);

my $pipeline = JSON::PP->new->decode($json_text);
my $name = $pipeline->{name};

my $nf = "#!/usr/bin/env nextflow\n\n";
$nf .= "nextflow.enable.dsl = 2\n\n";
$nf .= "// Pipeline: $name\n";
$nf .= "// Generated from Ergatis pipeline template by EELS\n";
$nf .= "// Source: ergatis-install/templates/pipelines/$name/\n\n";

# Collect all unique components
my %components;
for my $comp (@{$pipeline->{components} || []}) {
    my ($cname, $token) = split(/\./, $comp, 2);
    $token //= 'default';
    $components{$cname} = 1;
}

# Include component processes
$nf .= "// Component includes\n";
for my $comp (sort keys %components) {
    my $nf_file = $comp;
    if (defined $nf_dir && -f "$nf_dir/$comp.nf") {
        $nf .= "// include { ... } from './$comp'\n";
    } else {
        $nf .= "// include { ... } from './$comp'  // TODO: component .nf not found\n";
    }
}
$nf .= "\n";

# Generate workflow block from structure
$nf .= "workflow {\n";
if (defined $pipeline->{structure}) {
    my $indent = "    ";
    _render_structure($pipeline->{structure}, \$nf, $indent);
} else {
    $nf .= "    // No pipeline.layout - components listed from per-component layouts\n";
    for my $comp (@{$pipeline->{components} || []}) {
        my $safe = $comp;
        $safe =~ s/[^a-zA-Z0-9_]/_/g;
        $nf .= "    // $safe()\n";
    }
}
$nf .= "}\n";

if (defined $output) {
    open(my $ofh, '>', $output) or die "Can't write $output: $!";
    print $ofh $nf;
    close($ofh);
    print STDERR "Wrote $output\n";
} else {
    print $nf;
}

sub _render_structure {
    my ($node, $nf_ref, $indent) = @_;
    
    my $type = $node->{type} || '';
    
    if ($type eq 'component') {
        my $id = $node->{id};
        my $safe = $id;
        $safe =~ s/[^a-zA-Z0-9_]/_/g;
        ${$nf_ref} .= "${indent}${safe}()  // $id\n";
        return;
    }
    
    my $children = $node->{children} || [];
    return unless @$children;
    
    if ($type eq 'parallel') {
        ${$nf_ref} .= "${indent}// --- parallel ---\n";
        for my $child (@$children) {
            _render_structure($child, $nf_ref, $indent);
        }
        ${$nf_ref} .= "${indent}// --- end parallel ---\n";
    } elsif ($type eq 'serial') {
        for my $child (@$children) {
            _render_structure($child, $nf_ref, $indent);
        }
    } else {
        # root or unknown
        for my $child (@$children) {
            _render_structure($child, $nf_ref, $indent);
        }
    }
}
