#!/usr/bin/env perl

=head1 NAME

extract_component_docs.pl - Extract all documentation from Ergatis component source files

=head1 SYNOPSIS

    extract_component_docs.pl --ergatis_dir /path/to/ergatis-git --output_dir /path/to/output

=head1 DESCRIPTION

Extracts and preserves ALL documentation from Ergatis component source files:

    - Config file comments (;; lines) associated with parameters
    - Config file parameter descriptions (;-flag lines)
    - Component HTML documentation templates (.tmpl files)
    - XML workflow step names, executables, arguments, parameters
    - Workflow INI step comments and command details
    - Perl script POD documentation (NAME, SYNOPSIS, DESCRIPTION, OPTIONS)
    - CVS/version tags
    - Classification and interface metadata

Produces per-component YAML files with all extracted documentation.

=cut

use strict;
use warnings;
use File::Find;
use File::Basename qw(basename dirname);
use File::Spec::Functions qw(catfile);
use Getopt::Long;
use JSON;
use POSIX qw(strftime);

my ($ergatis_dir, $output_dir, $eels_data_dir);
GetOptions(
    'ergatis_dir|e=s' => \$ergatis_dir,
    'output_dir|o=s'  => \$output_dir,
    'eels_data|d=s'   => \$eels_data_dir,
);

die "Usage: $0 --ergatis_dir DIR --output_dir DIR [--eels_data DIR]\n"
    unless $ergatis_dir && $output_dir && -d $ergatis_dir;

mkdir $output_dir unless -d $output_dir;

my $components_dir = catfile($ergatis_dir, 'components');
my $workflow_dir   = catfile($ergatis_dir, 'workflow');
my $src_perl_dir   = catfile($ergatis_dir, 'src', 'perl');
my $docs_dir       = $eels_data_dir ? catfile($eels_data_dir, 'component_docs') : undef;

# Build index of Perl scripts by basename for POD extraction
my %perl_scripts;
if (-d $src_perl_dir) {
    opendir(my $dh, $src_perl_dir) or die "Cannot open $src_perl_dir: $!";
    for my $f (readdir $dh) {
        next unless $f =~ /\.pl$/;
        my $base = $f;
        $base =~ s/\.pl$//;
        $perl_scripts{$base} = catfile($src_perl_dir, $f);
    }
    closedir $dh;
}

# Process each component
opendir(my $cdh, $components_dir) or die "Cannot open $components_dir: $!";
my @components = sort grep { -d catfile($components_dir, $_) && !/^\./ } readdir($cdh);
closedir $cdh;

my $count = 0;
for my $comp (@components) {
    my $comp_dir = catfile($components_dir, $comp);
    my $doc = extract_component($comp, $comp_dir);
    
    write_yaml($doc, catfile($output_dir, "$comp.doc.yaml"));
    $count++;
}

print STDERR "Extracted documentation for $count components to $output_dir/\n";

sub extract_component {
    my ($name, $comp_dir) = @_;

    my $doc = {
        component    => $name,
        extracted_at => strftime("%Y-%m-%dT%H:%M:%S", localtime),
        source_files => [],
    };

    # 1. Config file
    my $config_file = catfile($comp_dir, "$name.config");
    if (-f $config_file) {
        push @{$doc->{source_files}}, "$name.config";
        $doc->{config} = parse_config_with_docs($config_file);
    }

    # 2. Component XML (main workflow template)
    my $xml_file = catfile($comp_dir, "$name.xml");
    if (-f $xml_file) {
        push @{$doc->{source_files}}, "$name.xml";
        $doc->{workflow_xml} = parse_xml_docs($xml_file);
    }

    # 3. Iterator XMLs
    for my $iter_file (sort glob(catfile($comp_dir, "$name.i*.xml"))) {
        my $bn = basename($iter_file);
        push @{$doc->{source_files}}, $bn;
        my $iter_name = $bn;
        $iter_name =~ s/^.*\.(i\d+)\.xml$/$1/;
        $doc->{iterator_xml}{$iter_name} = parse_xml_docs($iter_file);
    }

    # 4. Workflow INI files
    my $wf_dir = catfile($workflow_dir, $name);
    if (-d $wf_dir) {
        for my $ini_file (sort glob(catfile($wf_dir, "*.ini"))) {
            my $bn = basename($ini_file);
            push @{$doc->{source_files}}, "workflow/$bn";
            $doc->{workflow_ini}{$bn} = parse_ini_with_docs($ini_file);
        }
    }

    # 5. Component HTML documentation template
    if ($docs_dir && -f catfile($docs_dir, "$name.tmpl")) {
        my $tmpl_file = catfile($docs_dir, "$name.tmpl");
        push @{$doc->{source_files}}, "component_docs/$name.tmpl";
        $doc->{component_doc} = read_file_text($tmpl_file);
    }

    # 6. Related Perl scripts - find by executable references in XML
    my @executables = find_executables($doc);
    my @pod_docs;
    for my $exec (@executables) {
        my $script_name = basename($exec);
        $script_name =~ s/\.pl$//;
        # Also try the raw name
        for my $try ($script_name, $exec) {
            $try =~ s/.*\///;  # strip path
            $try =~ s/\.pl$//;
            if ($perl_scripts{$try}) {
                my $pod = extract_pod($perl_scripts{$try});
                if ($pod && length($pod) > 10) {
                    push @pod_docs, {
                        script => basename($perl_scripts{$try}),
                        pod    => $pod,
                    };
                }
                last;
            }
        }
    }
    # Also try the component name itself
    for my $try ($name, $name =~ s/-/_/gr) {
        if ($perl_scripts{$try} && !grep { $_->{script} eq basename($perl_scripts{$try}) } @pod_docs) {
            my $pod = extract_pod($perl_scripts{$try});
            if ($pod && length($pod) > 10) {
                push @pod_docs, {
                    script => basename($perl_scripts{$try}),
                    pod    => $pod,
                };
            }
        }
    }
    $doc->{perl_pod} = \@pod_docs if @pod_docs;

    return $doc;
}

sub parse_config_with_docs {
    my ($file) = @_;

    open my $fh, '<', $file or return {};
    my $result = {
        _raw_comments => [],
        sections      => {},
    };

    my $current_section = '_preamble';
    my @pending_comments;
    my @section_order;

    while (my $line = <$fh>) {
        chomp $line;

        # Section header
        if ($line =~ /^\s*\[([^\]]+)\]\s*$/) {
            $current_section = $1;
            $current_section =~ s/^\s+|\s+$//g;
            push @section_order, $current_section;
            $result->{sections}{$current_section} //= { _order => [] };
            @pending_comments = ();
            next;
        }

        # Comment line (;; or ;-flag style)
        if ($line =~ /^\s*;+\s?(.*)$/) {
            push @pending_comments, $1;
            next;
        }

        # Key = value
        if ($line =~ /^\s*(\S+)\s*=\s*(.*)$/) {
            my ($key, $value) = ($1, $2);
            $value =~ s/\s+$//;

            # Clean up the Ergatis variable syntax for display
            my $clean_key = $key;
            $clean_key =~ s/^\$;(.+)\$;$/$1/;

            my $entry = {
                key     => $clean_key,
                token   => $key,
                value   => $value,
            };
            $entry->{comments} = [@pending_comments] if @pending_comments;
            @pending_comments = ();

            $result->{sections}{$current_section} //= { _order => [] };
            push @{$result->{sections}{$current_section}{_order}}, $clean_key;
            $result->{sections}{$current_section}{$clean_key} = $entry;
            next;
        }

        # Blank line resets pending comments
        if ($line =~ /^\s*$/) {
            if (@pending_comments) {
                push @{$result->{_raw_comments}}, @pending_comments;
            }
            @pending_comments = ();
        }
    }
    close $fh;

    $result->{_section_order} = \@section_order;
    return $result;
}

sub parse_xml_docs {
    my ($file) = @_;

    open my $fh, '<', $file or return {};
    my $content = do { local $/; <$fh> };
    close $fh;

    my $result = {
        steps    => [],
        comments => [],
    };

    # Extract XML comments
    while ($content =~ /<!--\s*(.*?)\s*-->/gs) {
        push @{$result->{comments}}, $1;
    }

    # Extract command blocks with full detail
    while ($content =~ /<command>(.*?)<\/command>/gs) {
        my $block = $1;
        my $step = {};

        if ($block =~ /<type>\s*(.*?)\s*<\/type>/s)       { $step->{type} = $1; }
        if ($block =~ /<name>\s*(.*?)\s*<\/name>/s)        { $step->{name} = $1; }
        if ($block =~ /<executable>\s*(.*?)\s*<\/executable>/s) { $step->{executable} = $1; }
        if ($block =~ /<arg>\s*(.*?)\s*<\/arg>/s)          { $step->{arg} = $1; $step->{arg} =~ s/\s+/ /g; }
        if ($block =~ /<state>\s*(.*?)\s*<\/state>/s)      { $step->{state} = $1; }

        # Extract all param key/value pairs
        my @params;
        while ($block =~ /<param>\s*(.*?)\s*<\/param>/gs) {
            my $pblock = $1;
            my ($k, $v);
            if ($pblock =~ /<key>\s*(.*?)\s*<\/key>/s)     { $k = $1; $k =~ s/^\s+|\s+$//g; }
            if ($pblock =~ /<value>\s*(.*?)\s*<\/value>/s)  { $v = $1; $v =~ s/^\s+|\s+$//g; }
            push @params, { key => $k, value => $v } if defined $k;
        }
        $step->{params} = \@params if @params;

        push @{$result->{steps}}, $step;
    }

    # Extract commandSet names
    while ($content =~ /<commandSet[^>]*>.*?<name>\s*(.*?)\s*<\/name>/gs) {
        push @{$result->{command_set_names}}, $1;
    }

    # Extract INCLUDE directives
    while ($content =~ /<INCLUDE\s+([^>]+)>/g) {
        push @{$result->{includes}}, $1;
    }

    return $result;
}

sub parse_ini_with_docs {
    my ($file) = @_;

    open my $fh, '<', $file or return {};
    my $result = { sections => {} };
    my $current_section = '_header';
    my @pending_comments;

    while (my $line = <$fh>) {
        chomp $line;

        if ($line =~ /^\s*\[([^\]]+)\]\s*$/) {
            $current_section = $1;
            $result->{sections}{$current_section} //= { entries => [], comments => [] };
            @pending_comments = ();
            next;
        }

        if ($line =~ /^\s*[;#]+\s*(.*)$/) {
            push @pending_comments, $1;
            next;
        }

        if ($line =~ /^\s*(\S+)\s*=\s*(.*)$/) {
            my ($key, $value) = ($1, $2);
            $value =~ s/\s+$//;
            $result->{sections}{$current_section} //= { entries => [], comments => [] };
            my $entry = { key => $key, value => $value };
            $entry->{comments} = [@pending_comments] if @pending_comments;
            @pending_comments = ();
            push @{$result->{sections}{$current_section}{entries}}, $entry;
            next;
        }

        if ($line =~ /^\s*$/ && @pending_comments) {
            $result->{sections}{$current_section} //= { entries => [], comments => [] };
            push @{$result->{sections}{$current_section}{comments}}, @pending_comments;
            @pending_comments = ();
        }
    }
    close $fh;
    return $result;
}

sub extract_pod {
    my ($file) = @_;

    open my $fh, '<', $file or return '';
    my $in_pod = 0;
    my @pod_lines;

    while (my $line = <$fh>) {
        if ($line =~ /^=(\w+)/) {
            $in_pod = ($1 ne 'cut');
            push @pod_lines, $line if $in_pod;
            next;
        }
        push @pod_lines, $line if $in_pod;
    }
    close $fh;

    return join('', @pod_lines);
}

sub find_executables {
    my ($doc) = @_;
    my %seen;
    my @execs;

    # From XML steps
    for my $section (qw(workflow_xml), map { "iterator_xml" } keys %{$doc->{iterator_xml} // {}}) {
        my $data;
        if ($section eq 'workflow_xml') {
            $data = $doc->{workflow_xml};
        } else {
            for my $k (keys %{$doc->{iterator_xml} // {}}) {
                $data = $doc->{iterator_xml}{$k};
                for my $step (@{$data->{steps} // []}) {
                    if ($step->{executable} && !$seen{$step->{executable}}++) {
                        push @execs, $step->{executable};
                    }
                }
            }
            next;
        }
        next unless $data;
        for my $step (@{$data->{steps} // []}) {
            if ($step->{executable} && !$seen{$step->{executable}}++) {
                push @execs, $step->{executable};
            }
        }
    }

    return @execs;
}

sub read_file_text {
    my ($file) = @_;
    open my $fh, '<', $file or return '';
    local $/;
    my $text = <$fh>;
    close $fh;
    return $text;
}

sub write_yaml {
    my ($doc, $outfile) = @_;

    open my $fh, '>', $outfile or die "Cannot write $outfile: $!";

    print $fh "---\n";
    print $fh "# Ergatis Component Documentation\n";
    print $fh "# Extracted from source by extract_component_docs.pl\n";
    print $fh "# Source: TIGR/JCVI/IGS Ergatis bioinformatics workflow system\n";
    print $fh "#\n";
    print $fh "# This file preserves ALL documentation, comments, parameter descriptions,\n";
    print $fh "# and structural details from the original Ergatis source files.\n\n";

    yaml_key($fh, 'component', $doc->{component}, 0);
    yaml_key($fh, 'extracted_at', $doc->{extracted_at}, 0);
    yaml_list($fh, 'source_files', $doc->{source_files}, 0);

    # Component HTML documentation
    if ($doc->{component_doc}) {
        print $fh "\n# Component documentation (from Ergatis web UI help template)\n";
        yaml_block($fh, 'component_documentation', $doc->{component_doc}, 0);
    }

    # Config file with full documentation
    if ($doc->{config}) {
        print $fh "\n# Configuration file - all sections, parameters, defaults, and inline comments\n";
        print $fh "config:\n";
        my $cfg = $doc->{config};
        for my $section (@{$cfg->{_section_order} // []}) {
            my $sdata = $cfg->{sections}{$section} // next;
            print $fh "  $section:\n";
            for my $key (@{$sdata->{_order} // []}) {
                my $entry = $sdata->{$key} // next;
                next if ref($entry) ne 'HASH';
                if ($entry->{comments} && @{$entry->{comments}}) {
                    for my $c (@{$entry->{comments}}) {
                        print $fh "    # $c\n";
                    }
                }
                my $val = $entry->{value} // '';
                $val = quote_yaml($val);
                print $fh "    $key: $val\n";
            }
        }
    }

    # Workflow XML
    if ($doc->{workflow_xml}) {
        print $fh "\n# Main workflow XML template - step definitions\n";
        write_xml_section($fh, 'workflow_xml', $doc->{workflow_xml});
    }

    # Iterator XMLs
    if ($doc->{iterator_xml}) {
        for my $iter (sort keys %{$doc->{iterator_xml}}) {
            print $fh "\n# Iterator $iter - per-input processing steps\n";
            write_xml_section($fh, "iterator_$iter", $doc->{iterator_xml}{$iter});
        }
    }

    # Workflow INI files
    if ($doc->{workflow_ini}) {
        for my $ini_name (sort keys %{$doc->{workflow_ini}}) {
            print $fh "\n# Workflow INI: $ini_name\n";
            print $fh "workflow_ini_${ini_name}:\n";
            my $ini = $doc->{workflow_ini}{$ini_name};
            for my $section (sort keys %{$ini->{sections} // {}}) {
                print $fh "  $section:\n";
                my $sdata = $ini->{sections}{$section};
                if ($sdata->{comments} && @{$sdata->{comments}}) {
                    for my $c (@{$sdata->{comments}}) {
                        print $fh "    # $c\n";
                    }
                }
                for my $entry (@{$sdata->{entries} // []}) {
                    if ($entry->{comments} && @{$entry->{comments}}) {
                        for my $c (@{$entry->{comments}}) {
                            print $fh "    # $c\n";
                        }
                    }
                    my $val = quote_yaml($entry->{value} // '');
                    print $fh "    $entry->{key}: $val\n";
                }
            }
        }
    }

    # Perl POD documentation
    if ($doc->{perl_pod} && @{$doc->{perl_pod}}) {
        print $fh "\n# Perl script documentation (POD)\n";
        print $fh "perl_scripts:\n";
        for my $pod_entry (@{$doc->{perl_pod}}) {
            print $fh "  - script: $pod_entry->{script}\n";
            yaml_block($fh, '    pod', $pod_entry->{pod}, 0);
        }
    }

    close $fh;
}

sub write_xml_section {
    my ($fh, $label, $data) = @_;
    print $fh "$label:\n";

    if ($data->{comments} && @{$data->{comments}}) {
        print $fh "  xml_comments:\n";
        for my $c (@{$data->{comments}}) {
            print $fh "    - " . quote_yaml($c) . "\n";
        }
    }

    if ($data->{command_set_names} && @{$data->{command_set_names}}) {
        print $fh "  command_sets:\n";
        for my $n (@{$data->{command_set_names}}) {
            print $fh "    - " . quote_yaml($n) . "\n";
        }
    }

    if ($data->{includes} && @{$data->{includes}}) {
        print $fh "  includes:\n";
        for my $inc (@{$data->{includes}}) {
            print $fh "    - " . quote_yaml($inc) . "\n";
        }
    }

    if ($data->{steps} && @{$data->{steps}}) {
        print $fh "  steps:\n";
        for my $step (@{$data->{steps}}) {
            print $fh "    - name: " . quote_yaml($step->{name} // 'unnamed') . "\n";
            print $fh "      type: " . quote_yaml($step->{type} // '') . "\n" if $step->{type};
            print $fh "      executable: " . quote_yaml($step->{executable} // '') . "\n" if $step->{executable};
            print $fh "      arg: " . quote_yaml($step->{arg} // '') . "\n" if $step->{arg};
            if ($step->{params} && @{$step->{params}}) {
                print $fh "      params:\n";
                for my $p (@{$step->{params}}) {
                    print $fh "        - key: " . quote_yaml($p->{key} // '') . "\n";
                    print $fh "          value: " . quote_yaml($p->{value} // '') . "\n";
                }
            }
        }
    }
}

sub yaml_key {
    my ($fh, $key, $value, $indent) = @_;
    my $pad = '  ' x $indent;
    print $fh "$pad$key: " . quote_yaml($value // '') . "\n";
}

sub yaml_list {
    my ($fh, $key, $list, $indent) = @_;
    my $pad = '  ' x $indent;
    print $fh "$pad$key:\n";
    for my $item (@{$list // []}) {
        print $fh "$pad  - " . quote_yaml($item) . "\n";
    }
}

sub yaml_block {
    my ($fh, $key, $text, $indent) = @_;
    my $pad = '  ' x $indent;
    print $fh "$pad$key: |\n";
    for my $line (split /\n/, $text) {
        print $fh "$pad  $line\n";
    }
}

sub quote_yaml {
    my ($val) = @_;
    return '""' unless defined $val;
    return '""' if $val eq '';
    # Quote if contains special YAML characters
    if ($val =~ /[:{}\[\]&*?|>!%@`,#\n]/ || $val =~ /^\s/ || $val =~ /\s$/ || $val =~ /^['"]/) {
        $val =~ s/\\/\\\\/g;
        $val =~ s/"/\\"/g;
        return "\"$val\"";
    }
    return $val;
}
