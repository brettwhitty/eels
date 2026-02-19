#!/usr/bin/env perl
# extend_edam.pl - Fetch EDAM terms for bio.tools entries missing from edam_mapping.json
use strict;
use warnings;
use JSON;
use LWP::UserAgent;

my $eels = "$ENV{HOME}/repos/eels";

open my $fh, '<', "$eels/data/edam_mapping.json" or die $!;
my $ed = decode_json(do { local $/; <$fh> });
close $fh;

open $fh, '<', "$eels/data/biotools_mapping.json" or die $!;
my $bt = decode_json(do { local $/; <$fh> });
close $fh;

my %edam_comps = map { $_->{component} => 1 } @{$ed->{mapping}};

my $ua = LWP::UserAgent->new(timeout => 10);
my $added = 0;

for my $m (@{$bt->{mapping}}) {
    next unless $m->{matched};
    next if $edam_comps{$m->{component}};

    my $bid = $m->{biotoolsID};
    my $resp = $ua->get("https://bio.tools/api/tool/$bid/?format=json");
    next unless $resp->is_success;
    my $info = eval { decode_json($resp->decoded_content) } or next;
    sleep 0.3;

    my (@ops, @topics, @inputs, @outputs);
    for my $func (@{$info->{function} || []}) {
        for my $op (@{$func->{operation} || []}) {
            push @ops, $op->{term} if $op->{term};
        }
        for my $inp (@{$func->{input} || []}) {
            my $e = { term => $inp->{data}{term} // '' };
            $e->{format} = [map { $_->{term} } @{$inp->{format} || []}];
            push @inputs, $e;
        }
        for my $out (@{$func->{output} || []}) {
            my $e = { term => $out->{data}{term} // '' };
            $e->{format} = [map { $_->{term} } @{$out->{format} || []}];
            push @outputs, $e;
        }
    }
    for my $t (@{$info->{topic} || []}) {
        push @topics, $t->{term} if $t->{term};
    }

    next unless @ops || @topics;

    push @{$ed->{mapping}}, {
        component      => $m->{component},
        biotoolsID     => $bid,
        tool_name      => $info->{name} // $m->{tool_name},
        edam_operations => \@ops,
        edam_topics     => \@topics,
        edam_inputs     => \@inputs,
        edam_outputs    => \@outputs,
    };
    $edam_comps{$m->{component}} = 1;
    $added++;
    printf "  Added EDAM for %-30s (%s)\n", $m->{component}, $bid;
}

# Update totals
my (%uops, %utopics);
for my $m (@{$ed->{mapping}}) {
    $uops{$_} = 1 for @{$m->{edam_operations} || []};
    $utopics{$_} = 1 for @{$m->{edam_topics} || []};
}
$ed->{total_mapped} = scalar @{$ed->{mapping}};
$ed->{unique_operations} = scalar keys %uops;
$ed->{unique_topics} = scalar keys %utopics;

open my $out, '>', "$eels/data/edam_mapping.json" or die $!;
print $out JSON->new->pretty->canonical->encode($ed);
close $out;

printf "\nAdded %d EDAM entries. Total: %d mapped, %d operations, %d topics\n",
    $added, $ed->{total_mapped}, $ed->{unique_operations}, $ed->{unique_topics};
