#!/usr/bin/env perl
# extend_tool_catalog.pl - Add executables from categorized steps to tool catalog
use strict;
use warnings;
use JSON;
use File::Slurp qw(read_file write_file);

my $eels = "$ENV{HOME}/repos/eels";

# Load existing tool catalog
open my $tc_fh, '<', "$eels/data/tool_catalog.json" or die $!;
my @existing = @{decode_json(do { local $/; <$tc_fh> })};
close $tc_fh;
my %existing_names = map { $_->{name} => 1 } @existing;

# Load all categorized steps
my %all_execs;
opendir my $dh, "$eels/data/categorized_steps" or die "Can't open categorized_steps: $!";
while (my $f = readdir $dh) {
    next unless $f =~ /\.json$/;
    my $comp = $f; $comp =~ s/\.json$//;
    my $data = do { open my $sfh, '<', "$eels/data/categorized_steps/$f" or die $!; local $/; decode_json(<$sfh>) };
    for my $step (@{$data->{steps} || []}) {
        next unless $step->{category} eq 'tool_execution';
        my $exe = $step->{executable} || '';
        my $name = $exe;
        $name =~ s|.*/||;
        $name =~ s|^\{\{BIN_DIR\}\}/||;
        $name =~ s|^perl\s+||;
        $name =~ s|^sh\s+||;
        $name =~ s|\.pl$||; $name =~ s|\.sh$||; $name =~ s|\.py$||;
        $name =~ s/^\s+|\s+$//g;
        next if !$name || $name =~ /^\{\{/ || $name =~ /^[;'"]/;
        next if length($name) > 60;
        
        push @{$all_execs{$name}{components}}, $comp;
        $all_execs{$name}{raw_exe} = $exe unless $all_execs{$name}{raw_exe};
    }
}
closedir $dh;

my $new_count = 0;
for my $name (keys %all_execs) {
    $new_count++ unless $existing_names{$name};
}
print "Existing catalog: " . scalar(@existing) . " tools\n";
print "Total from steps: " . scalar(keys %all_execs) . " unique executables\n";
print "New (not in catalog): $new_count\n";

my %cat_labels = (
    os_system => '1. OS/System tools',
    custom_perl => '2. Custom Perl scripts/wrappers (TIGR/JCVI/IGS)',
    custom_binary => '3. Custom binaries (TIGR/JCVI/IGS)',
    open_source => '4. Open-source public tools',
    closed_source => '5. Closed-source private tools',
);

my @new_entries;
for my $name (sort keys %all_execs) {
    next if $existing_names{$name};
    my $exe = $all_execs{$name}{raw_exe};
    my @comps = @{$all_execs{$name}{components}};
    
    my $cat;
    if ($exe =~ /\{\{BIN_DIR\}\}/) {
        $cat = 'custom_perl';
    } elsif ($exe =~ m{/usr/local/packages/|/opt/}) {
        $cat = 'open_source';
    } elsif ($exe =~ m{/devel/ANNOTATION/|/local/projects/|/home/}) {
        $cat = 'custom_binary';
    } elsif ($name =~ /^(cat|cp|mv|rm|find|sort|tail|zcat|env|mkdir|chmod|gzip|gunzip|tar|sed|awk|grep|cut|head|wc|touch|ln|echo|date|hostname)$/) {
        $cat = 'os_system';
    } else {
        $cat = 'custom_perl';
    }
    
    push @new_entries, {
        name => $name,
        path => $exe,
        category_id => $cat,
        category => $cat_labels{$cat} || $cat,
        components => \@comps,
    };
}

my @full = (@existing, @new_entries);
@full = sort { lc($a->{name}) cmp lc($b->{name}) } @full;

write_file("$eels/data/tool_catalog_full.json", JSON->new->pretty->canonical->encode(\@full));

my %counts;
$counts{$_->{category_id}}++ for @new_entries;
print "\nNew entries by category:\n";
for my $c (sort keys %counts) {
    printf "  %-50s %d\n", $cat_labels{$c} || $c, $counts{$c};
}
print "Total catalog: " . scalar(@full) . " tools\n";
