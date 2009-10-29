package Geo::GoogleEarth::Pluggable::Folder;
use base qw{Geo::GoogleEarth::Pluggable::Base}; 
use warnings;
use strict;

use blib;
use Module::Pluggable search_path => "Geo::GoogleEarth::Pluggable::Plugin";
use base qw{Method::Autoload};

use Geo::GoogleEarth::Pluggable::Placemark;
use Geo::GoogleEarth::Pluggable::NetworkLink;

our $VERSION ='0.01';

=head1 NAME

Geo::GoogleEarth::Pluggable::Folder - Geo::GoogleEarth::Pluggable::Folder object

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new;
  my $folder=$document->Folder(name=>"My Folder");

=head1 DESCRIPTION

Geo::GoogleEarth::Pluggable::Folder is a L<Geo::GoogleEarth::Pluggable::Base> with a few other methods.

=head1 USAGE

  my $folder=$document->Folder();  #add folder to $document
  my $subfolder=$folder->Folder(); #add folder to $folder

=head1 METHODS

=cut

sub initialize {
  my $self = shift();
  %$self=@_;
  $self->{"packages"}=[$self->plugins];
}

=head2 Folder

Constructs a new Folder object and appends it to the parent folder object.  Returns the object reference if you need to make any setting changes after construction.

  my $folder=$folder->Folder(name=>"My Folder");
  $folder->Folder(name=>"My Folder");

=cut

sub Folder {
  my $self=shift();
  my $obj=Geo::GoogleEarth::Pluggable::Folder->new(document=>$self->document, @_);
  $self->data($obj);
  return $obj;
}

=head2 NetworkLink

Constructs a new NetworkLink object and appends it to the parent folder object.  Returns the object reference if you need to make any setting changes after construction.

  $folder->NetworkLink(name=>"My NetworkLink", url=>"./anotherdoc.kml");

=cut

sub NetworkLink {
  my $self=shift();
  my $obj=Geo::GoogleEarth::Pluggable::NetworkLink->new(document=>$self->document, @_);
  $self->data($obj);
  return $obj;
}

=head2 type

Returns the object type.

  my $type=$folder->type;

=cut

sub type {
  my $self=shift();
  return "Folder";
}

=head2 structure

Returns a hash reference for feeding directly into L<XML::Simple>.

Unfortunately, this package cannot guarantee how Folders, Placemarks, or NetworkLinks are ordered when in the same folder.  Because, it's a hash reference!  But, order is preserved within a group of Folders, NetworkLink, and Placemarks.

  my $structure=$folder->structure;

=cut

sub structure {
  my $self=shift();
  my $structure={name=>[$self->name]}; #{Placemark=>[], Folder=>[], ...}
  foreach my $obj ($self->data) {
    #$obj->type should be one of Placemark, Folder, NetworkLink
    $structure->{$obj->type}=[] unless ref($structure->{$obj->type}) eq 'ARRAY';
    #$obj->structure should be a HASH structure to feed into XML::Simple
    push @{$structure->{$obj->type}}, $obj->structure;
  }
  return $structure;
}

=head2 data

Pushes arguments onto data array and returns an array or reference that holds folder object content.  This is a list of objects that supports a type and structure method.

  my $data=$folder->data;
  my @data=$folder->data;
  $folder->data($placemark);

=cut

sub data {
  my $self=shift();
  $self->{'data'} = [] unless ref($self->{'data'}) eq ref([]);
  my $data=$self->{'data'};
  if (@_) {
    push @$data, @_;
  }
  return wantarray ? @$data : $data;
}

=head1 BUGS

=head1 LIMITATIONS

Due to a limitation in L<XML::Simple> and the fact that we feed it a hash, it is not possible to specify the order of Folders, Placemarks and NetworkLinks.  However, this package does preserve the order of creation within groups of Folders, Placemarks, and NetworkLinks.  A good work around is to put unique types of objects in folders.  

=head1 TODO

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
