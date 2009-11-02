package Geo::GoogleEarth::Pluggable::Contrib::LinearRing;
use base qw{Geo::GoogleEarth::Pluggable::Placemark};
use warnings;
use strict;

our $VERSION='0.03';

=head1 NAME

Geo::GoogleEarth::Pluggable::Contrib::LinearRing - Geo::GoogleEarth::Pluggable LinearRing Object

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new();
  $document->LinearRing();

=head1 DESCRIPTION

Geo::GoogleEarth::Pluggable::Contrib::LinearRing is a L<Geo::GoogleEarth::Pluggable::Placemark> with a few other methods.

=head1 USAGE

  my $placemark=$document->LinearRing(name=>"LinearRing Name",
                                   coordinates=>[[lat,lon,alt],
                                                 [lat,lon,alt],...]);

=head1 CONSTRUCTOR

=head2 new

  my $placemark=$document->LinearRing();

=head1 METHODS

=head2 subtype

=cut

sub subtype {
  return "Polygon";
}

=head2 substructure

Returns a hash reference for feeding directly into L<XML::Simple>.

  my $substructure=$placemark->substructure;

=cut

sub substructure {
  my $self=shift;
  my %data=%$self;
  $data{"tessellate"}=[1] unless defined $data{"tessellate"};
  my $coordinates=$self->coordinates_stringify($data{"coordinates"});
  $data{"outerBoundaryIs"}=[{LinearRing=>[{coordinates=>[$coordinates]}]}];
  delete(@data{qw{name coordinates}});
  return \%data;
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
