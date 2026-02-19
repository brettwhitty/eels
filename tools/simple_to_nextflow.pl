#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use File::Basename;
use File::Slurp;
use Getopt::Long;

use Data::Dumper;

my $input = undef;

my $ergatis_globals = {
    'compress_bsml'                   =>  '{{COMPRESS_BSML_OUTPUT}}',
    'compress_raw'                    =>  '{{COMPRESS_RAW_OUTPUT}}',
    'ergatis_dir'                     =>  '{{ERGATIS_DIR}}',
    'ergatis_dir_docs'                =>  '{{DOCS_DIR}}',
    'ergatis_dir_bin'                 =>  '{{BIN_DIR}}',
    'component_config'                =>  '{{COMPONENT_CONFIG}}',
    'component_name'                  =>  '{{COMPONENT_NAME}}',
    'component_input_file_pathname'   =>  '{{I_FILE_PATH}}',
    'component_input_file_basename'   =>  '{{I_FILE_BASE}}',
    'component_tmp_dir'               =>  '{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}',
    'component_run_dir'               =>  '{{WORKFLOW_REPOSITORY}}',
    'component_output_dir'            =>  '{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}',
    'pipeline_config'                 =>  '{{PIPELINE_XML}}',
};

my $ergatis_root = '/opt/ergatis';

GetOptions(
    'input|i=s'     =>  \$input,
);

unless (defined($input) && -f $input) {
    die "Provide input file with --input flag";
}

my $component_name = basename($input);
$component_name =~ s/^([^\.]+).*$/$1/;

my $defaults = {
    'compress_bsml'         =>  1,
    'compress_raw'          =>  1,
    'ergatis_dir'           =>  "'".$ergatis_root."'",
    'ergatis_dir_bin'       =>  "'".$ergatis_root."/bin'",
    'ergatis_dir_docs'      =>  "'".$ergatis_root."/docs'",
    'component_name'        =>  "'$component_name'",
    'component_config'      =>  "'$component_name.config'",
    'component_tmp_dir'     =>  "'/tmp'",
    'component_run_dir'     =>  "'/run'",
    'component_output_dir'  =>  "'/output'",
};

my $json_file = read_file($input);

my $o = from_json($json_file);

#use Data::Dumper;
#print Dumper $o;

my $commandSet = $o->{'commandSetRoot'}->{'commandSet'};

print "## globals\n";
#print "bin_dir = '/opt/ergatis/bin'\n";
#print "component_output_dirname = ''\n";
#print "component_output_basename = ''\n";
foreach my $global(sort keys %{$ergatis_globals}) {
    if (defined($defaults->{$global})) {
        print "$global = ".$defaults->{$global}."\n";
    } else {
        print "$global = ''\n";
    }
}
print "\n";

my $processes = [];
my $component_vars = {};
foreach my $item(@{$commandSet->{'_members'}}) {
    my $type = $item->{'_type'};
    if ($type eq 'commandSet') {
        print STDERR "commandSet currently not handled, skipping.\n";
        next;
    } 
    my $command = $item->{'command'};
    my $params_ref = always_array($command->{'param'});
    my $cmd = $command->{'executable'};
    
    my $params;
    my $has_params = 0;
    my $param_stdout = undef;
    my $param_stderr = undef;
    foreach my $param(@{$params_ref}) {
        if ($param->{'key'} eq 'stdout') {
            $param_stdout = $param->{'value'};
            next;
        }
        if ($param->{'key'} eq 'stderr') {
            $param_stderr = $param->{'value'};
            next;
        }
        $params .= ' '.$param->{'key'} . ' '. $param->{'value'};
        $has_params++;
    }
    if ($has_params) {
        $cmd .= $params;
    }
    if (defined($command->{'arg'})) {
        $cmd .= ' '.$command->{'arg'};
    }
    if (defined($param_stdout)) {
        $cmd .= " 1>$param_stdout";
    }
    if (defined($param_stderr)) {
        $cmd .= " 2>$param_stdout";
    }

    my $name = $command->{'name'};
    $name =~ s/\s+/_/g;

    $cmd = replace_vars($ergatis_globals, $cmd);
    my $vars = get_process_vars($name, $cmd);    
    $cmd = replace_vars($vars, $cmd);

    my $process = "process $name {\n"
                . "    script:\n"
                . "    \"\"\"\n"
                . "    $cmd\n"
                . "    \"\"\"\n"
                . "}\n";

    foreach my $var(keys %{$vars}) {
        $component_vars->{$var} = "''";
    }

    push(@{$processes}, $process);
}
#print Dumper $component_vars;

print "## component vars\n";
foreach my $component_var(sort keys %{$component_vars}) {
    print "$component_var = ".$component_vars->{$component_var}."\n";
}
print "\n";
foreach my $process(@{$processes}) {
    print $process;
}

sub always_array {
    my ($param_ref) = @_;

    if (ref($param_ref) eq 'ARRAY') {
        return $param_ref;
    } elsif (ref($param_ref) eq 'HASH') {
        my $a = [];
        push(@{$a}, $param_ref);
        $param_ref = $a;
        return $param_ref;
    } else {
        return [];
    }
}

sub replace_vars {
    my ($vars_ref, $cmd) = @_;

    foreach my $key(keys %{$vars_ref}) {
        my $val = $vars_ref->{$key};
        $cmd =~ s/\Q$val\E/\$\{$key\}/g;
    }
    return $cmd;
}

sub get_process_vars {
    my ($name, $cmd) = @_;

    my $vars = {};
    while ($cmd =~ /(\{\{([^}]+)\}\})/g) {
       my $var = $1;
       my $key = lc($2);
       $vars->{"opts_$name.$key"} = $var;
    }
    return $vars;
}
