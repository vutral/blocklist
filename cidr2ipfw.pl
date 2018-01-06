#!/usr/bin/perl

use strict;
use warnings;

my $cidrfile = "level1.cidr";

open(CIDRF,$cidrfile);

print "ipfw table 5000 flush\n";
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "ipfw -q table 5000 add ".$range."\n";
}

