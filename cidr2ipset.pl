#!/usr/bin/perl

use strict;
use warnings;

my $NAME='level1';
if(defined($ARGV[0]) && $ARGV[0] ne '') {
  $NAME = $ARGV[0];
}

my $cidrfile = "$NAME.cidr";

open(CIDRF,$cidrfile);

print "ipset destroy blocklist\n";
print "ipset create blocklist hash:net maxelem 300000\n";
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "ipset add blocklist ".$range."\n";
}

