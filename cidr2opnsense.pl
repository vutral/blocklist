#!/usr/bin/perl

use strict;
use warnings;

my $cidrfile = "level1.cidr";

open(CIDRF,$cidrfile);

my $n=0;
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "".$range." ; N".$n++."\n";
}

