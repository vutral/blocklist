#!/usr/bin/perl

use strict;
use warnings;

my $NAME='level1';
if(defined($ARGV[0]) && $ARGV[0] ne '') {
  $NAME = $ARGV[0];
}
my $IPSET_NAME="blocklist";
if(defined($ENV{'IPSET_NAME'}) && $ENV{'IPSET_NAME'} ne '') {
  $IPSET_NAME = $ENV{'IPSET_NAME'};
}

my $cidrfile = "$NAME.cidr";

open(CIDRF,$cidrfile);

print "ipset destroy ".$IPSET_NAME."\n";
print "ipset create ".$IPSET_NAME." hash:net maxelem 400000\n";
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "ipset add ".$IPSET_NAME." ".$range."\n";
}

