package Geo::GoogleEarth::Pluggable::Placemark;
use base qw{Geo::GoogleEarth::Pluggable::Base};
use XML::LibXML::LazyBuilder qw{E};
use strict;
use warnings;
use Scalar::Util qw{reftype};

our $VERSION='0.02';

=head1 NAME

Geo::GoogleEarth::Pluggable::Placemark - Base for Geo::GoogleEarth::Pluggable Placemarks

=head1 SYNOPSIS

  use base qw{Geo::GoogleEarth::Pluggable::Placemark};

=head1 DESCRIPTION

The is the base of all Geo::GoogleEarth::Pluggable packages.

=head1 USAGE

=head1 METHODS

=head2 type

=cut

sub type {
  return "Placemark";
}

=head2 style

Sets or returns the Placemark Style or StyleMap object.

style=>$style is a short cut for styleUrl=>$style->url

=cut

sub style {
  my $self=shift;
  $self->{"style"}=shift if @_;
  return $self->{"style"};
}

=head2 styleUrl

This overrides style->url if defined.

=cut

sub styleUrl {
  my $self=shift;
  my $url=undef;
  $url=$self->style->url if defined($self->style) && $self->style->can("url");
  $self->{"styleUrl"}||=$url;
  $self->{"styleUrl"}=shift if @_;
  return $self->{"styleUrl"};
}

=head1 LookAt

Sets or returns the LookAt Object

=cut

sub LookAt {
  my $self=shift;
  $self->{"LookAt"}=shift if @_;
  return $self->{"LookAt"};
}

=head2 visibility

Sets or returns visibility.  The value is either 1 or 0 but defaults to undef which the same as 1.

  my $visibility=$placemark->visibility;

=cut

sub visibility {
  my $self=shift;
  $self->{"visibility"}=shift if @_;
  return $self->{"visibility"};
}

=head2 node

=cut

sub node {
  my $self=shift;
  my @element=();
  push @element, E(name=>{}, $self->name);
  push @element, E(visibility=>{}, $self->visibility)
    if defined $self->visibility;
  push @element, E(styleUrl=>{}, $self->styleUrl) if defined $self->styleUrl;
  push @element, $self->subnode;
  return E($self->type=>{}, @element);
}
=head2 coordinates

The coordinates array is used consistantly for all placemark objects.

  my $coordinates=$placemark->coordinates(
                              [
                                [$lon, $lat, $alt],
                                {lat=>$lat, lon=>$lon, alt=>$alt},
                                GPS::Point,
                                Geo::Point,
                                Net::GPSD::Point,
                              ]
                            );

  my $coordinates=$placemark->coordinates(
                             Geo::Line,          #TODO
                            );


=cut

sub coordinates {
  my $self=shift;
  $self->{"coordinates"}=shift if @_;
  return $self->{"coordinates"};
}

=head2 coordinates_stringify

=cut

sub coordinates_stringify {
  my $self=shift;
  my $data=$self->coordinates;
  my $string="";
  if (ref($data) eq "ARRAY") {
    $string=join(" ", map {$self->point_stringify($_)} @$data);
  } else {
    die(sprintf(qq{Error: the coordinates_stringify method does not understand coordinates value type "%s"}, ref($data)));
  }
  return $string;
}

=head2 point_stringify

Most of this code was taken from GPS::Point->initializeMulti

=cut

sub point_stringify {
  my $self=shift;
  my $point=shift;
  my $data={};
  if (ref($point) eq "Geo::Point") {
    $point=$point->in('wgs84') unless $point->proj eq "wgs84";
    $data->{'lat'}=$point->latitude;
    $data->{'lon'}=$point->longitude;
    $data->{'alt'}=0;
  } elsif (ref($point) eq "GPS::Point") {
    $data->{'lat'}=$point->lat;
    $data->{'lon'}=$point->lon;
    $data->{'alt'}=$point->alt;
  } elsif (ref($point) eq "Net::GPSD::Point") {
    $data->{'lat'}=$point->latitude;
    $data->{'lon'}=$point->longitude;
    $data->{'alt'}=$point->altitude;
  } elsif (reftype($point) eq "HASH") {
    #{lat=>$lat, lon=>$lon, alt=>$alt}
    $data->{'lat'}=$point->{'lat'}||$point->{'latitude'};
    $data->{'lon'}=$point->{'lon'}||$point->{'long'}||$point->{'longitude'};
    $data->{'alt'}=$point->{'alt'}||$point->{'altitude'}||
                   $point->{'elevation'}||$point->{'hae'}||$point->{'elev'}||0;
  } elsif (reftype($point) eq "ARRAY") {
    #[$lon, $lat, $alt]
    $data->{'lon'}=$point->[0];
    $data->{'lat'}=$point->[1];
    $data->{'alt'}=$point->[2]||0;
  }
  return join(",", @{$data}{qw{lon lat alt}});
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
