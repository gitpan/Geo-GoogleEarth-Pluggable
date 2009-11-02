package Geo::GoogleEarth::Pluggable::NetworkLink;
use base qw{Geo::GoogleEarth::Pluggable::Base};
use warnings;
use strict;

our $VERSION='0.03';

=head1 NAME

Geo::GoogleEarth::Pluggable::NetworkLink - Geo::GoogleEarth::Pluggable::NetworkLink

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new();
  $document->NetworkLink(url=>"./anotherdocument.cgi");

=head1 DESCRIPTION

Geo::GoogleEarth::Pluggable::NetworkLink is a L<Geo::GoogleEarth::Pluggable::Base> with a few other methods.

=head1 USAGE

  my $networklink=$document->NetworkLink(name=>"My NetworkLink",
                                         url=>"./anotherdocument.cgi");

=head2 type

Returns the object type.

  my $type=$networklink->type;

=cut

sub type {
  my $self=shift();
  return "NetworkLink";
}

=head2 structure

Returns a hash reference for feeding directly into L<XML::Simple>.

  my $structure=$networklink->structure;

=cut

sub structure {
  my $self=shift;
  my %data=%$self;
  $data{"Link"}={href=>[$self->url]};
  delete(@data{qw{url document}});
  $data{$_}=[$data{$_}] foreach keys %data;
  return \%data; 
}

=head2 url

Sets or returns the Uniform Resource Locator (URL) for the NetworkLink

  my $url=$networklink->url;
  $networklink->url("./newdoc.cgi");

=cut

sub url {
  my $self=shift();
  if (@_) {
    $self->{'url'}=shift();
  }
  return defined($self->{'url'}) ? $self->{'url'} : 'http://localhost/';
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
