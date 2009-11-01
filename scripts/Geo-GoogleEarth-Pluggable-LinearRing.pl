#!/usr/bin/perl
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable;

=head1 NAME

Geo-GoogleEarth-Pluggable-LinearRing.pl - Geo::GoogleEarth::Pluggable LinearRing Example

=cut

my $document=Geo::GoogleEarth::Pluggable->new(name=>"My Document");
my @pt=(
         {lat=>38.5, lon=>-77.1},
         {lat=>38.6, lon=>-77.2},
         {lat=>38.7, lon=>-77.2},
         {lat=>38.8, lon=>-77.1},
       );

push @pt, $pt[0]; #ring last = first

$document->LinearRing(name=>"My LinearRing", coordinates=>\@pt);
#use Data::Dumper qw{Dumper};
#print Dumper($document->structure);
print $document->render;
