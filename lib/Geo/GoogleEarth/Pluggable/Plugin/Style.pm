package Geo::GoogleEarth::Pluggable::Plugin::Style;
use Geo::GoogleEarth::Pluggable::Style;
use Scalar::Util qw{blessed};
use warnings;
use strict;

our $VERSION='0.06';

=head1 NAME

Geo::GoogleEarth::Pluggable::Plugin::Style - Geo::GoogleEarth::Pluggable Style Plugin Methods

=head1 METHODS

Methods in this package are AUTOLOADed into the  Geo::GoogleEarth::Pluggable::Folder namespace at runtime.

=head2 Style

Constructs a new Style object and appends it to the document object.  Returns the Style object reference.

  my $style=$folder->Style(
                           id => $id, #default is good
                           IconStyle  => {},
                           LineStyle  => {},
                           PolyStyle  => {},
                           LabelStyle => {},
                           ListStyle  => {},
                          );

=cut

sub Style {
  my $self=shift;
  my %data=@_;
  foreach my $key (keys %data) {
    next unless $key=~m/Style$/;
    my $ref=$data{$key};
    if (blessed($ref) and $ref->can("type") and $ref->type eq "Style") {
      $data{$key}=$ref->{$key}; #allow Style to be blessed objects
    }
  }
  my $obj=Geo::GoogleEarth::Pluggable::Style->new(
                      document=>$self->document,
                      %data,
                    );
  $self->document->data($obj);
  return $obj;
}

=head2 IconStyle

  my $style=$folder->IconStyle(
                               color => $color,
                               scale => $scale,
                               href  => $url,
                              );

=cut

sub IconStyle {
  my $self=shift;
  my %data=@_;
  my $id=delete($data{"id"}); #undef is fine here...
  return $self->Style(id=>$id, IconStyle=>\%data);
}

=head2 LineStyle

  my $color={red=>255, green=>255, blue=>255, alpha=>255};
  my $style=$folder->LineStyle(color=>$color);

=cut

sub LineStyle {
  my $self=shift;
  my %data=@_;
  $data{"width"}=1 unless defined $data{"width"};
  my $id=delete($data{"id"}); #undef is fine here...
  return $self->Style(id=>$id, LineStyle=>\%data);
}

=head2 PolyStyle

  my $color={red=>255, green=>255, blue=>255, alpha=>255};
  my $style=$folder->PolyStyle(color=>$color);

=cut

sub PolyStyle {
  my $self=shift;
  my %data=@_;
  my $id=delete($data{"id"}); #undef is fine here...
  return $self->Style(id=>$id, PolyStyle=>\%data);
}

=head1 TODO

Need to determine what methods should be in the Folder package and what should be on the Plugin/Style package and why.

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
