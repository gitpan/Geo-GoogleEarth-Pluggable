package Geo::GoogleEarth::Pluggable::Contrib::Point;
use strict;
use warnings;
use base qw{Geo::GoogleEarth::Pluggable::Placemark};

our $VERSION='0.01';

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

  my $placemark=$document->Point(
              name       => "White House",
              address    => "1600 Pennsylvania Ave NW, Washington, DC 20006",
            );

=head1 METHODS

=head2 structure

Returns a hash reference for feeding directly into L<XML::Simple>.

  my $structure=$placemark->structure;

=cut

sub structure {
  my $self=shift();
  my $structure={name=>[$self->name]}; #Not sure why but I need at least one key=>[] in the object for XML:Simple.
  my %skip=map {$_=>1} (qw{Point lat lon alt options name});
  if (defined($self->lat) and defined($self->lon)) {
    $structure->{'Point'} = [{coordinates => [join(",", $self->lon,
                                                        $self->lat,
                                                        $self->alt || 0)]}]
  }
  foreach my $key (keys %$self) {
    next if exists $skip{$key};
    $structure->{$key} = {content=>$self->function($key)};
  }
# $structure->{'description'} = {content=>$self->description}
#                                   if defined $self->description;
# $structure->{'visibility'}  = {content=>$self->visibility}
#                                   if defined $self->visibility;
# $structure->{'address'}     = {content=>$self->address}
#                                   if defined $self->address;
# $structure->{'Snippet'}     = {content=>$self->snippet}
#                                   if defined $self->snippet;
  my %options=$self->options;
  foreach my $key (keys %options) {
    my $hash=$structure->{$key}||{};
    my @hash=%$hash;
    push @hash, %{$self->options->{$key}};
    $structure->{$key}={@hash};
  }
  return $structure;
}

=head2 address

Sets or returns address

  my $address=$placemark->address;

=cut

sub address {
  my $self=shift();
  return $self->function('address', @_);
}

=head2 description

Set or returns the description.  Google Earth uses this as the HTML description in the Placemark popup window.

=cut

sub description {
  my $self=shift();
  return $self->function('description', @_);
}

=head2 snippet

Sets or returns the "snippet", which is the descriptive text shown in the
places list.  Optionally sets the maximum number of lines to show.

  my $snippet=$placemark->snippet($text);
  $placemark->snippet($text, {maxLines=>2});
  $placemark->snippet("", {maxLines=>0});        #popular setting

=cut

sub snippet {
  my $self=shift();
  return $self->function('Snippet', @_);
}

=head2 visibility

Sets or returns visibility

  my $visibility=$placemark->visibility;

=cut

sub visibility {
  my $self=shift();
  return $self->function('visibility', @_);
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
