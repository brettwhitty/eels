#!/usr/bin/env perl
use strict;
use warnings;
use JSON;
use File::Slurp;
use File::Basename;
use Digest::SHA qw(sha256_hex);

my $input = shift or die "Usage: $0 <pipeline.json>\n";
my $data = from_json(read_file($input));
my $name = $data->{name} || basename($input, '.json');

# Collect all components
my @components;
collect_components($data->{structure}, \@components);

# Build pipeline steps
my @steps;
my $idx = 1;
for my $comp (@components) {
    push @steps, {
        step_number => $idx++,
        name => $comp,
        description => "Ergatis component: $comp",
    };
}

my $bco = {
    object_id => "urn:eels:pipeline:$name",
    spec_version => "https://w3id.org/ieee/ieee-2791-schema/2791object.json",
    etag => sha256_hex($name . scalar(@components)),
    provenance_domain => {
        name => $name,
        version => "1.0",
        created => "2026-02-19T00:00:00Z",
        modified => "2026-02-19T00:00:00Z",
        contributors => [{
            contribution => ["createdBy"],
            name => "EELS extraction"
        }],
        license => "https://opensource.org/licenses/Artistic-2.0",
    },
    usability_domain => [
        "Ergatis pipeline template: $name",
        "Contains " . scalar(@components) . " component steps",
        "Extracted from ergatis-install/templates/pipelines/",
    ],
    description_domain => {
        keywords => ["ergatis", "pipeline", "bioinformatics"],
        pipeline_steps => \@steps,
    },
    execution_domain => {
        script => [{ uri => { uri => "pipeline.layout" } }],
        script_driver => "Ergatis workflow engine",
        software_prerequisites => [
            map { { name => $_, uri => { uri => "urn:eels:component:$_" } } }
            @components
        ],
        external_data_endpoints => [],
        environment_variables => {},
    },
    io_domain => {
        input_subdomain => [{ uri => { uri => "pipeline.config" } }],
        output_subdomain => [{ uri => { uri => "pipeline output directory" } }],
    },
    parametric_domain => [],
    error_domain => {
        empirical_error => {},
        algorithmic_error => {},
    },
};

print to_json($bco, { utf8 => 1, pretty => 1, canonical => 1 });

sub collect_components {
    my ($node, $list) = @_;
    if ($node->{type} && $node->{type} eq 'component') {
        push @$list, $node->{id};
        return;
    }
    for my $child (@{$node->{children} || []}) {
        collect_components($child, $list);
    }
}
