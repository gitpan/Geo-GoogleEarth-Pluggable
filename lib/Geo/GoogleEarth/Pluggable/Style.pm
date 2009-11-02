package Geo::GoogleEarth::Pluggable::Style;
use base qw{Geo::GoogleEarth::Pluggable::Base};
use warnings;
use strict;

our $VERSION='0.02';

=head1 NAME

Geo::GoogleEarth::Pluggable::Style - Geo::GoogleEarth::Pluggable Style Object

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new();
  $document->Style();

=head1 DESCRIPTION

Geo::GoogleEarth::Pluggable::Style is a L<Geo::GoogleEarth::Pluggable::Base> with a few other methods.

=head1 USAGE

  my $style=$document->Style(id=>"Style_Internal_HREF",
                             iconHref=>"http://.../path/image.png");

=head1 CONSTRUCTOR

=head2 new

  my $style=$document->Style(id=>"Style_Internal_HREF",
                             iconHref=>"http://.../path/image.png");

=head1 METHODS

=head2 type

Returns the object type.

  my $type=$style->type;

=cut

sub type {
  return "Style";
}

=head2 structure

Returns a hash reference for feeding directly into L<XML::Simple>.

  my $structure=$style->structure;

=cut

sub structure {
  my $self=shift();
#{
#          'Style' => {
#                     'IconStyle' => {
#                                    'Icon' => {
#                                              'href' => 'http://maps.google.com/mapfiles/kml/paddle/L.png'
#                                            }
#                                  },
#                     'id' => 'http://maps.google.com/mapfiles/kml/paddle/L.png'
#                   }
#        };
  my $structure={id=>$self->id};
  my %skip=map {$_=>1} (qw{id iconHref});
  if (defined($self->iconHref)) {
    $structure->{'IconStyle'} = [{Icon=> [{href=>[$self->iconHref]}]}];
  }
  foreach my $key (keys %$self) {
    next if exists $skip{$key};
    $structure->{$key} = {content=>$self->function($key)};
  }
  my %options=$self->options;
  foreach my $key (keys %options) {
    my $hash=$structure->{$key}||{};
    my @hash=%$hash;
    push @hash, %{$self->options->{$key}};
    $structure->{$key}={@hash};
  }
  return $structure;
}

=head2 id

=cut

sub id {
  my $self=shift();
  $self->{'id'}=shift if @_;
  return $self->{'id'};
}

=head2 iconHref

=cut

sub iconHref {
  my $self=shift();
  $self->{'iconHref'}=shift() if (@_);
  return $self->{'iconHref'};
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
