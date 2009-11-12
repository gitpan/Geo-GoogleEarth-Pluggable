package Geo::GoogleEarth::Pluggable::Style;
use base qw{Geo::GoogleEarth::Pluggable::Base};
use XML::LibXML::LazyBuilder qw{E};
use warnings;
use strict;

our $VERSION='0.04';

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

=head2 node

=cut

sub node {
  my $self=shift;
  my @element=();
  foreach my $style (keys %$self) {
    next if $style eq "document";
    next if $style eq "id";
    my @subelement=();
    unless (ref($self->{$style}) eq "HASH") {
      warn("Warning: Expecting $style to be a hash reference.");
      next;
    } else {
      foreach my $key (keys %{$self->{$style}}) {
        my $value=$self->{$style}->{$key};
        #printf "Style: %s, Key: %s, Value: %s\n", $style, $key, $value;
        #push @subelement, E(key=>{}, $key);
        if ($key eq "color") {
          push @subelement, E($key=>{}, $self->color($value));
        } elsif ($key eq "href") {
          push @subelement, E(Icon=>{}, E($key=>{}, $value));
        } elsif (ref($value) eq "HASH") {
          push @subelement, E($key=>$value);
        } elsif (ref($value) eq "ARRAY") {
          push @subelement, E($key=>{}, join(",", @$value));
        } else {
          push @subelement, E($key=>{}, $value);
        }
      }
    }
    push @element, E($style=>{}, @subelement);
  }
  return E(Style=>{id=>$self->id}, @element);
}

=head2 id

=cut

sub id {
  my $self=shift();
  $self->{'id'}=shift if @_;
  $self->{'id'}=$self->document->nextId("s") unless defined $self->{"id"};
  return $self->{'id'};
}

=head2 url

=cut

sub url {
  my $self=shift;
  return sprintf("#%s", $self->id);
}

=head2 document

=cut

sub document {shift->{"document"}};

=head2 color

Returns a color code for use in the XML structure given many different inputs.

  my $color=$style->color("FFFFFFFF"); #AABBGGRR in hex
  my $color=$style->color({color="FFFFFFFF"});
  my $color=$style->color({red=>255, green=>255, blue=>255, alpha=>255});
  my $color=$style->color({rgb=>[255,255,255], alpha=>255});
  my $color=$style->color({abgr=>[255,255,255,255]});
 #my $color=$style->color({name=>"blue", alpha=>255});  #TODO with ColorNames

=cut

sub color {
  my $self=shift;
  my $color=shift;
  if (ref($color) eq "HASH") {
    if (defined($color->{"color"})) {
      return $color->{"color"} || "FFFFFFFF";
    } else {
      my $a=$color->{"a"} || $color->{"alpha"} || $color->{"abgr"}->[0];
      my $b=$color->{"b"} || $color->{"blue"}  || $color->{"abgr"}->[1] || 0;
      my $g=$color->{"g"} || $color->{"green"} || $color->{"abgr"}->[2] || 0;
      my $r=$color->{"r"} || $color->{"red"}   || $color->{"abgr"}->[3] || 0;
      $a=255 unless defined $a;
      return unpack("H8", pack("C4", $a,$b,$g,$r));
    }
  } else {
    return $color || "FFFFFFFF";
  }
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
