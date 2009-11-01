package Geo::GoogleEarth::Pluggable::Plugin::Default;
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable::Contrib::Point;
use Geo::GoogleEarth::Pluggable::Contrib::LineString;
use Geo::GoogleEarth::Pluggable::Contrib::LinearRing;

our $VERSION='0.02';

=head1 NAME

Geo::GoogleEarth::Pluggable::Plugin::Default - Geo::GoogleEarth::Pluggable Default Plugin Methods

=head2 METHODS

Methods in this package are AUTOLOADed into the  Geo::GoogleEarth::Pluggable::Folder namespace at runtime.

=head2 CONVENTIONS

Plugin Naming Convention: Geo::GoogleEarth::Pluggable::Plugin::CPANID (e.g. "MRDVT")
Object Naming Convention: Geo::GoogleEarth::Pluggable::Contrib::"$method" (e.g. Point, CircleByCenterPoint)

You should only have one plugin pointing to all of your contributed objects.

The package should be named after the plugin not the objects since there is a many to one relationship.  (e.g. Geo-GoogleEarth-Pluggable-Plugin-MRDVT)

=head2 Point

Constructs a new Placemark Point object and appends it to the parent folder object.  Returns the object reference if you need to make any setting changes after construction.

  my $point=$folder->Point(name=>"My Placemark",
                           lat=>38.897607,
                           lon=>-77.036554,
                           alt=>0);

=cut

sub Point {
  my $self=shift; #This will be a Geo::GoogleEarth::Pluggable::Folder object
  my $obj=Geo::GoogleEarth::Pluggable::Contrib::Point->new(@_);
  $self->data($obj);
  return $obj;
}

=head2 LineString

  $folder->LineString(name=>"My Placemark",
                      coordinates=>[
                                     [lat,lon,alt],
                                     {lat=>$lat,lon=>$lon,alt=>$alt},
                                   ]);

=cut

sub LineString {
  my $self=shift;
  my $obj=Geo::GoogleEarth::Pluggable::Contrib::LineString->new(@_);
  $self->data($obj);
  return $obj;
}

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
