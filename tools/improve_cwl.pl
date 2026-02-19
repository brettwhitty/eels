#!/usr/bin/env perl
use strict;
use warnings;
use JSON;
use File::Slurp;
use File::Basename;

my $comp_dir = shift || 'data/components';
my $out_dir  = shift || 'generated/cwl_improved';

mkdir $out_dir unless -d $out_dir;

opendir(my $dh, $comp_dir) or die "Can't open $comp_dir: $!";
my @files = sort grep { /\.json$/ } readdir($dh);
closedir($dh);

my $count = 0;
for my $f (@files) {
    my $data = from_json(read_file("$comp_dir/$f"));
    my $name = $data->{name} || $f;
    $name =~ s/\.json$//;
    
    # Get the primary tool executable
    my @tools = grep { $_->{name} ne 'create output directory' && $_->{name} ne 'dtd validation' }
                @{$data->{tool_execution} || []};
    
    my $base_cmd = 'UNKNOWN';
    if (@tools) {
        $base_cmd = $tools[0]->{executable};
        # Clean up Ergatis variable references
        $base_cmd =~ s/\$;\w+\$;//g;
        $base_cmd =~ s|^.*/||;  # basename
        $base_cmd = $name unless $base_cmd;
    }
    
    my @params = @{$data->{parameters} || []};
    my $desc = $data->{description} || "Ergatis component: $name";
    my $classification = $data->{classification} || '';
    
    # Build CWL
    my @lines;
    push @lines, "cwlVersion: v1.2";
    push @lines, "class: CommandLineTool";
    push @lines, "id: $name";
    push @lines, "label: $name";
    push @lines, "doc: |";
    push @lines, "  $desc";
    push @lines, "  Classification: $classification" if $classification;
    push @lines, "  Source: Ergatis component (TIGR/JCVI/IGS)";
    push @lines, "";
    push @lines, "baseCommand: [$base_cmd]";
    push @lines, "";
    
    # Requirements
    push @lines, "requirements:";
    push @lines, "  InlineJavascriptRequirement: {}";
    push @lines, "";
    
    # Inputs
    push @lines, "inputs:";
    
    # Input file based on input_modes
    my $modes = $data->{input_modes} || {};
    push @lines, "  input_file:";
    push @lines, "    type: File";
    push @lines, "    inputBinding:";
    push @lines, "      prefix: -i";
    push @lines, "    doc: Input file";
    
    # Add parameters as inputs
    my $pos = 2;
    for my $p (@params) {
        my $pname = lc($p->{name});
        my $default = $p->{default} || '';
        
        # Skip infrastructure params
        next if $pname =~ /^(compress_|split_|filter_hsps|group_count|output_|tmp_|project$)/i;
        
        # Determine type from default value
        my $type = 'string';
        if ($default =~ /^\d+$/) {
            $type = 'int';
        } elsif ($default =~ /^\d+\.\d+$/ || $default =~ /^\d+e[+-]?\d+$/i) {
            $type = 'float';
        } elsif ($default =~ /^(true|false|0|1)$/i && $pname =~ /compress|filter|split|skip|use_/) {
            $type = 'boolean';
        }
        
        push @lines, "  $pname:";
        push @lines, "    type: $type?";
        if ($default ne '') {
            if ($type eq 'int') {
                push @lines, "    default: $default";
            } elsif ($type eq 'float') {
                push @lines, "    default: $default";
            } else {
                push @lines, "    default: \"$default\"";
            }
        }
        push @lines, "    doc: $p->{name} parameter";
    }
    
    push @lines, "";
    
    # Outputs based on output_formats
    push @lines, "outputs:";
    my @outputs = @{$data->{output_formats} || []};
    if (@outputs) {
        for my $out (@outputs) {
            my $out_name = $out;
            $out_name =~ s/_output_list$//;
            my $ext = $out_name;
            $ext = 'xml' if $ext eq 'bsml';
            $ext = 'txt' if $ext eq 'raw';
            
            push @lines, "  ${out_name}_output:";
            push @lines, "    type: File";
            push @lines, "    outputBinding:";
            push @lines, "      glob: \"*.$ext\"";
            push @lines, "    doc: $out_name format output";
        }
    } else {
        push @lines, "  output_file:";
        push @lines, "    type: File";
        push @lines, "    outputBinding:";
        push @lines, "      glob: \"*.out\"";
    }
    
    my $cwl = join("\n", @lines) . "\n";
    write_file("$out_dir/$name.cwl", $cwl);
    $count++;
}

print "Generated $count improved CWL files\n";
