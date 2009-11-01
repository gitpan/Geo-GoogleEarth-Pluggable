#!/usr/bin/perl
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable;

=head1 NAME

Geo-GoogleEarth-Pluggable-Point.pl - Geo::GoogleEarth::Pluggable Point Example

=cut

my $document=Geo::GoogleEarth::Pluggable->new(name=>"My Document");
$document->Point(name=>"My Name", lat=>39, lon=>-77);
#use Data::Dumper qw{Dumper};
#print Dumper($document->structure);
print $document->render;
