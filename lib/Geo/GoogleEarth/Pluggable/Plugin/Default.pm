package Geo::GoogleEarth::Pluggable::Plugin::Default;
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable::Contrib::Point;
use Geo::GoogleEarth::Pluggable::Contrib::LineString;
use Geo::GoogleEarth::Pluggable::Contrib::LinearRing;

our $VERSION='0.02';

=head1 NAME

Geo::GoogleEarth::Pluggable::Plugin::Default - Geo::GoogleEarth::Pluggable Default Plugin Methods

=head1 METHODS

Methods in this package are AUTOLOADed into the  Geo::GoogleEarth::Pluggable::Folder namespace at runtime.

=head1 CONVENTIONS

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

=head1 TODO

Need to determine what methods should be in the Folder package and what should be on the Plugin/Default package and why.

=head1 BUGS

Please log on RT and send to the geo-perl email list.

=head1 SUPPORT

Try geo-perl email list.

=head1 AUTHOR

    Michael R. Davis (mrdvt92)
    CPAN ID: MRDVT

=head1 COPYRIGHT

This program is free software licensed under the...

        The BSD License

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<Geo::GoogleEarth::Pluggable> creates a GoogleEarth Document.

L<Geo::GoogleEarth::Pluggable::Base> is the base for Geo::GoogleEarth::Pluggable::* packages.

L<Geo::GoogleEarth::Pluggable::Folder> is a Geo::GoogleEarth::Pluggable folder object.

L<Geo::GoogleEarth::Pluggable::NetworkLink> is a Geo::GoogleEarth::Pluggable NetworkLink object.

L<Geo::GoogleEarth::Pluggable::Placemark> is a Geo::GoogleEarth::Pluggable Placemark object.

L<Geo::GoogleEarth::Pluggable::Style> is a Geo::GoogleEarth::Pluggable Style object.

L<XML::Simple> is used by this package to generate XML from a data structure.

=cut

1;
