#!/usr/bin/env perl

use strict;
use warnings;
use File::Find;
use File::Basename;
use XML::LibXML;
use JSON;

my $components_dir = $ARGV[0] || die "Usage: $0 <components_dir>\n";

my $iterator_data = {};

find(sub {
    return unless /\.i\d+\.xml$/;
    my $file = $File::Find::name;
    my $component = basename(dirname($file));
    
    my $iterator_num = $1 if $_ =~ /\.i(\d+)\.xml$/;
    
    eval {
        my $parser = XML::LibXML->new();
        my $doc = $parser->parse_file($file);
        
        my $root = $doc->documentElement();
        my $type = $root->getAttribute('type') || 'unknown';
        
        # Count commands
        my @commands = $root->findnodes('.//command');
        my $command_count = scalar(@commands);
        
        # Check for nested commandSets
        my @commandsets = $root->findnodes('.//commandSet');
        my $has_nested = scalar(@commandsets) > 1 ? 1 : 0;
        
        $iterator_data->{$component} ||= {};
        $iterator_data->{$component}->{"i$iterator_num"} = {
            file => $file,
            type => $type,
            command_count => $command_count,
            has_nested => $has_nested,
        };
    };
    
    warn "Error parsing $file: $@" if $@;
    
}, $components_dir);

print encode_json($iterator_data);
