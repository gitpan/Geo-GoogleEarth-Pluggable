#!/usr/bin/perl
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable;

=head1 NAME

Geo-GoogleEarth-Pluggable-Folders_with_Points.pl - Geo-GoogleEarth-Pluggable Folders and Points Example

=cut

my $document=Geo::GoogleEarth::Pluggable->new(name=>"My Document");
foreach my $f (3,4,5,6) {
  my $folder=$document->Folder(name=>"My Folder $f", description=>"F$f Desc");
  my $point=$folder->Point(name=>"My Point $f", lat=>"39.$f", lon=>"-77.$f"); 
}
#use Data::Dumper qw{Dumper};
#print Dumper($document->structure);
print $document->render;
