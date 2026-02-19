#!/usr/bin/env perl

use strict;
use warnings;
use JSON;
use File::Slurp;

my $json_dir = shift || die "Usage: $0 <json_dir>\n";

my $catalog = {};

opendir(my $dh, $json_dir) || die "Can't open $json_dir: $!";
my @files = grep { /\.i\d+\.json$/ && -f "$json_dir/$_" } readdir($dh);
closedir($dh);

foreach my $file (sort @files) {
    my ($component, $iter) = $file =~ /^(.+?)\.(i\d+)\.json$/;
    next unless $component;
    
    my $json_text = read_file("$json_dir/$file");
    my $data = decode_json($json_text);
    
    my $root = $data->{commandSetRoot}{commandSet};
    my $type = $root->{_type} || 'unknown';
    my $members = $root->{_members} || [];
    
    my $command_count = 0;
    my $has_nested = 0;
    
    foreach my $member (@$members) {
        if ($member->{_type} eq 'command') {
            $command_count++;
        } elsif ($member->{_type} eq 'commandSet') {
            $has_nested = 1;
        }
    }
    
    $catalog->{$component} ||= {};
    $catalog->{$component}{$iter} = {
        file => $file,
        type => $type,
        command_count => $command_count,
        has_nested => $has_nested ? JSON::true : JSON::false,
    };
}

print encode_json($catalog);
