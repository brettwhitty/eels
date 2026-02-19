#!/usr/bin/env perl

use strict;
use warnings;


my @xml_files = glob('*.xml');

foreach my $file(@xml_files) {
    if ($file =~ /^[^\.]+\.[^\.]+\.xml$/) {
        
        fix_include($file);

    }
}

sub fix_include {

    my ($file) = @_;

    if ($file =~ /template/) {
        return;
    }

    print STDERR "Making JSON for '$file'...\n";

#    system('sed -i -r "s/(\<INCLUDE[^>]+\")>/\1\/\>/g" '.$file);
    my $json = $file;
    $json =~ s/\.xml$/\.json/;

    system("../../workflow_xml_to_json.pl -i $file 1>$json 2>$json.log");

#    my $result = `xmllint $file`;

#    if ($?) {
#        print "Problem with '$file'; ERROR=$?\n";
#    }

}
