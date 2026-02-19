#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use File::Basename;
use File::Slurp;
use Getopt::Long;

my $input = undef;
my $output = undef;

GetOptions(
    'input|i=s'  => \$input,
    'output|o=s' => \$output,
);

unless (defined($input) && -f $input) {
    die "Provide input JSON file with --input flag\n";
}

my $component_name = basename($input);
$component_name =~ s/^([^.]+).*$/$1/;

my $json_file = read_file($input);
my $o = from_json($json_file);

my $commandSet = $o->{'commandSetRoot'}->{'commandSet'};
my $members = $commandSet->{'_members'} || [];

# Extract processes and their dependencies
my @processes;
my %process_vars;

foreach my $item (@{$members}) {
    my $type = $item->{'_type'};
    next if $type eq 'commandSet'; # skip nested commandSets for now

    my $command = $item->{'command'};
    my $name = $command->{'name'};
    $name =~ s/\s+/_/g;
    $name =~ s/[^a-zA-Z0-9_]/_/g;

    my $executable = $command->{'executable'} || '';
    
    # Skip Ergatis infrastructure commands
    next if $executable =~ /create_iterator_groups/;
    next if $executable =~ /replace_template_keys/;
    next if $executable =~ /create_file_iterator_list/;
    next if $executable =~ /create_list_file/;
    next if $name =~ /^create_(output|temp)_directory$/;

    # Build command line
    my $cmd = $executable;
    my @params;
    my $stdout_file;
    my $stderr_file;

    if (defined $command->{'param'}) {
        my $params_ref = ref($command->{'param'}) eq 'ARRAY' 
            ? $command->{'param'} 
            : [$command->{'param'}];
        
        foreach my $param (@{$params_ref}) {
            if ($param->{'key'} eq 'stdout') {
                $stdout_file = $param->{'value'};
                next;
            }
            if ($param->{'key'} eq 'stderr') {
                $stderr_file = $param->{'value'};
                next;
            }
            push @params, $param->{'key'} . ' ' . $param->{'value'};
        }
    }

    if (defined $command->{'arg'}) {
        $cmd .= ' ' . $command->{'arg'};
    }

    if (@params) {
        $cmd .= ' ' . join(' ', @params);
    }

    # Convert Ergatis handlebars to Nextflow params
    # {{VAR}} -> params.var (lowercase)
    my %vars_used;
    while ($cmd =~ /\{\{([^}]+)\}\}/g) {
        $vars_used{$1} = 1;
    }

    $cmd =~ s/\{\{([^}]+)\}\}/"\${params." . lc($1) . "}"/ge;
    
    # Also handle stdout/stderr
    if (defined $stdout_file) {
        $stdout_file =~ s/\{\{([^}]+)\}\}/"\${params." . lc($1) . "}"/ge;
    }

    push @processes, {
        name       => $name,
        executable => $executable,
        cmd        => $cmd,
        stdout     => $stdout_file,
        stderr     => $stderr_file,
        vars       => \%vars_used,
    };

    foreach my $v (keys %vars_used) {
        $process_vars{$v} = 1;
    }
}

# Generate Nextflow DSL2 workflow
my $nf = "#!/usr/bin/env nextflow\n\n";
$nf .= "nextflow.enable.dsl = 2\n\n";

# Params block
$nf .= "// Component: $component_name\n";
$nf .= "// Generated from Ergatis component JSON by EELS\n\n";
$nf .= "params {\n";
foreach my $var (sort keys %process_vars) {
    my $key = lc($var);
    $nf .= "    $key = ''\n";
}
$nf .= "}\n\n";

# Process definitions
my @process_names;
foreach my $proc (@processes) {
    my $pname = $proc->{name};
    push @process_names, $pname;

    $nf .= "process $pname {\n";
    
    # Add input/output channels for first real process
    if ($proc->{executable} =~ /\$\{params\./) {
        $nf .= "    input:\n";
        $nf .= "    path input_file\n\n";
    }

    $nf .= "    script:\n";
    $nf .= "    \"\"\"\n";
    $nf .= "    $proc->{cmd}";
    if (defined $proc->{stdout}) {
        $nf .= " \\\n        1>$proc->{stdout}";
    }
    if (defined $proc->{stderr}) {
        $nf .= " \\\n        2>$proc->{stderr}";
    }
    $nf .= "\n";
    $nf .= "    \"\"\"\n";
    $nf .= "}\n\n";
}

# Workflow block - serial chain
$nf .= "workflow {\n";
if (@process_names) {
    $nf .= "    // Serial execution chain\n";
    my $prev;
    foreach my $pname (@process_names) {
        if (!defined $prev) {
            $nf .= "    $pname()\n";
        } else {
            $nf .= "    $pname()\n";
        }
        $prev = $pname;
    }
}
$nf .= "}\n";

if (defined $output) {
    open(my $fh, '>', $output) or die "Can't write $output: $!";
    print $fh $nf;
    close($fh);
    print STDERR "Wrote $output\n";
} else {
    print $nf;
}
