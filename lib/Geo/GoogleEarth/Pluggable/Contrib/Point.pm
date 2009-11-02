package Geo::GoogleEarth::Pluggable::Contrib::Point;
use base qw{Geo::GoogleEarth::Pluggable::Placemark};
use warnings;
use strict;

our $VERSION='0.03';

=head1 NAME

Geo::GoogleEarth::Pluggable::Contrib::Point - Geo::GoogleEarth::Pluggable Point Object

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new();
  $document->Point();

=head1 DESCRIPTION

Geo::GoogleEarth::Pluggable::Contrib::Point is a L<Geo::GoogleEarth::Pluggable::Placemark> with a few other methods.

=head1 USAGE

  my $placemark=$document->Point(name=>"Point Name",
                                 lat=>$lat,
                                 lon=>$lon,
                                 alt=>$alt);

=head1 CONSTRUCTOR

=head2 new

  my $placemark=$document->Point(
              name       => "White House",
              lat        => 38.89769,       #signed decimal degrees WGS-84
              lon        => -77.036549,     #signed decimal degrees WGS-84
              alt        => 30,             #meters above ellipsoid WGS-84
            );

=head1 METHODS

=head2 subtype

=cut

sub subtype {
  return "Point";
}

=head2 substructure

Returns a hash reference for feeding directly into L<XML::Simple>.

  my $substructure=$placemark->substructure;

=cut

sub substructure {
  my $self=shift;
  return {coordinates => [join(",", $self->lon,
                                     $self->lat,
                                     $self->alt || 0)]};
}

=head2 lat

Sets or returns latitude. The format is signed decimal degrees WGS-84.

  my $lat=$placemark->lat;

=cut

sub lat {
  my $self=shift;
  $self->{'lat'}=shift if @_;
  return $self->{'lat'};
}

=head2 lon

Sets or returns longitude. The format is signed decimal degrees WGS-84.

  my $lon=$placemark->lon;

=cut

sub lon {
  my $self=shift;
  $self->{'lon'}=shift if @_;
  return $self->{'lon'};
}

=head2 alt

Sets or returns altitude. The units are meters above the ellipsoid WGS-84.

  my $alt=$placemark->alt;

Typically, Google Earth "snaps" Placemarks to the surface regardless of how the altitude is set.

=cut

sub alt {
  my $self=shift;
  $self->{'alt'}=shift if @_;
  return $self->{'alt'};
}

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

=cut

1;
