package Geo::GoogleEarth::Pluggable::Plugin::LinearRing;
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable::Contrib::LinearRing;

=head1 NAME

Geo::GoogleEarth::Pluggable::Plugin::LinearRing - Geo::GoogleEarth::Pluggable LinearRing Plugin Methods

=head2 METHODS

Methods in this package are AUTOLOADed into the  Geo::GoogleEarth::Pluggable::Folder namespace at runtime.

=head2 LinearRing

  $folder->LinearRing(name=>"My Placemark",
                      coordinates=>[
                                     [lat,lon,alt],
                                     [lat,lon,alt],
                                   ]);

=cut

sub LinearRing {
  my $self=shift;
  my $obj=Geo::GoogleEarth::Pluggable::Contrib::LinearRing->new(@_);
  $self->data($obj);
  return $obj;
}

1;
