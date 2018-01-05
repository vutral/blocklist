#!/usr/bin/perl

use strict;
use warnings;

my $cidrfile = "level1.cidr";

open(CIDRF,$cidrfile);

print "ipset create blocklist hash:net\n";
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "ipset add blocklist ".$range."\n";
}

