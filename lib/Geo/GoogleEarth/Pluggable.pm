package Geo::GoogleEarth::Pluggable;
use strict;
use base qw{Geo::GoogleEarth::Pluggable::Folder}; 
use Geo::GoogleEarth::Pluggable::Style;
use XML::LibXML::LazyBuilder qw{DOM E};
use Archive::Zip qw{COMPRESSION_DEFLATED};
use IO::Scalar qw{};

our $VERSION='0.07';

=head1 NAME

Geo::GoogleEarth::Pluggable - Generates GoogleEarth Documents

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document    = Geo::GoogleEarth::Pluggable->new(); #is a special Folder...
  my $folder      = $document->Folder();                #Geo::GoogleEarth::Pluggable::Folder object
  my $placemark   = $document->Point();             #Geo::GoogleEarth::Pluggable::Point object
  my $networklink = $document->NetworkLink();           #Geo::GoogleEarth::Pluggable::NetworkLink object
  my $style = $document->Style();                       #Geo::GoogleEarth::Pluggable::Style object
  print $document->render();

=head1 DESCRIPTION

Geo::GoogleEarth::Pluggable is a Perl object oriented interface that allows for the creation of XML documents that can be used with Google Earth.

Geo::GoogleEarth::Pluggable is a L<Geo::GoogleEarth::Pluggable::Folder> with a render method.

=head1 USAGE

This is all of the code you need to generate a complete Google Earth document.

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new;
  $document->Point(name=>"White House", lat=>38.897337, lon=>-77.036503);
  print $document->render;

=head2 document

=cut

sub document {shift};

=head2 render

Returns an XML document with an XML declaration and a root name of "Document"

  print $document->render;

=cut

sub render {
  my $self=shift();
  my @style=();
  my @stylemap=();
  my @element=();
  my @data=();
  push @data, E(name=>{}, $self->name) if defined $self->name;
  push @data, E(open=>{}, $self->open) if defined $self->open;
  foreach my $obj ($self->data) {
    if ($obj->can("type") and $obj->type eq "Style") {
      push @style, $obj->node;
    } elsif ($obj->can("type") and $obj->type eq "StyleMap") {
      push @stylemap, $obj->node;
    } else {
      push @element, $obj->node;
    }
  }
  my $d = DOM(E(kml=>{}, E(Document=>{}, @data, @style, @stylemap, @element)));
  return $d->toString;
}

=head2 archive

Returns a KMZ formatted Zipped archive of the XML document

  print $document->archive;

=cut

sub archive {
  my $self=shift;
  my $azip=Archive::Zip->new;
  my $member=$azip->addString($self->render, "doc.kml");
  $member->desiredCompressionMethod(COMPRESSION_DEFLATED);
  $member->desiredCompressionLevel(9);

  my $archive=q{};
  my $iosh=IO::Scalar->new( \$archive );
  $azip->writeToFileHandle($iosh);
  $iosh->close;
  return $archive;
}

=head2 xmlns

=cut

sub xmlns {
  my $self=shift;
  unless (defined($self->{'xmlns'})) {
    $self->{'xmlns'}={
            'xmlns'      => "http://www.opengis.net/kml/2.2",
            'xmlns:gx'   => "http://www.google.com/kml/ext/2.2",
            'xmlns:kml'  => "http://www.opengis.net/kml/2.2",
            'xmlns:atom' => "http://www.w3.org/2005/Atom",
                     };
  }
  return wantarray ? %{$self->{'xmlns'}} : $self->{'xmlns'};
}

=head2 nextId

  my $id=$document->nextId($type); #$type in {"s", "sm") Style or Style Map

=cut

sub nextId {
  my $self=shift;
  my $type=shift || "s";
  $self->{"nextId"}=0 unless defined $self->{"nextId"};
  return sprintf("%s-%s-%s", $type, "perl", $self->{"nextId"}++);
}


=head1 TODO

=over

=item Full support for LookAt and Style, and StyleMap

=item Support for default Polygon and Line styles that are nicer than GoogleEarth's

=item Support for DateTime object in the constructor that is promoted to the LookAt object.

=item Support for MultiPoint(coordinates=>[{},[],...]) (multiple name.$#coordinates)

=item Create a Great circle to LineString plugin

=item Create a GPSPoint plugin (Promote tag as name and datetime to LookAt)

=back

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

L<Geo::GoogleEarth::Pluggable::Placemark> is a Geo::GoogleEarth::Pluggable Placemark base object.

L<Geo::GoogleEarth::Pluggable::Style> is a Geo::GoogleEarth::Pluggable Style object.

=cut

1;
