#!/usr/bin/perl

use strict;
use warnings;
use Net::CIDR;
my $debug=0;

my $NAME="level1";
if($ARGV[0] ne '') {
  $NAME=$ARGV[0];
}

my $p2pfile = "$NAME.p2p";
my $cidrfile = "$NAME.cidr";
open(P2P, $p2pfile);
open(CIDRF, '>'.$cidrfile);
while(<P2P>) {
  my $line = $_;
  my ($comment, $range, @cidr);
  if($line =~ m/(.*):(\d+.\d+.\d+.\d+-\d+.\d+.\d+.\d+)$/) {
    my $comment = $1;
    my $range = $2;
    print 'range '.$range."\n" unless $debug==0;
    @cidr = Net::CIDR::range2cidr($range);
    foreach my $net (@cidr) {
      print 'net '.$net."\n";
      print CIDRF $net."\n";
    }
  }
  print $line."\n" unless $debug==0;
}
