#!/usr/bin/perl

use strict;
use warnings;

my $NAME='level1';
if(defined($ARGV[0]) && $ARGV[0] ne '') {
  $NAME = $ARGV[0];
}
my $LIST_NAME="blocklist";
if(defined($ENV{'LIST_NAME'}) && $ENV{'LIST_NAME'} ne '') {
  $LIST_NAME = $ENV{'LIST_NAME'};
}

my $cidrfile = "$NAME.cidr";

open(CIDRF,$cidrfile);

open(DSBL,'>/var/lib/rbldns/dsbl/'.$LIST_NAME);
while(<CIDRF>) {
  my $line = $_;
  $line =~ s/\n//g;
  my $range = $line;
  print DSBL $range."\n";
}

