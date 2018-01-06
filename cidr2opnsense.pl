#!/usr/bin/perl

use strict;
use warnings;

my $NAME='level1';
if(defined($ARGV[0]) && $ARGV[0] ne '') {
  $NAME = $ARGV[0];
}

my $cidrfile = $NAME.".cidr";

open(CIDRF,$cidrfile);

my $n=0;
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print "".$range." ; N".$n++."\n";
}

