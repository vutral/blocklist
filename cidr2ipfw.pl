#!/usr/bin/perl

use strict;
use warnings;

my $NAME='level1';
if(defined($ARGV[0]) && $ARGV[0] ne '') {
  $NAME = $ARGV[0];
}
my $TABLE=5000;
if(defined($ENV{'IPFW_TABLE'}) && $ENV{'IPFW_TABLE'} ne '') {
  $TABLE=$ENV{'IPFW_TABLE'};
}

my $cidrfile = $NAME.".cidr";

open(CIDRF,$cidrfile);

print "ipfw table ".$TABLE." flush\n";
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "ipfw -q table ".$TABLE." add ".$range."\n";
}

