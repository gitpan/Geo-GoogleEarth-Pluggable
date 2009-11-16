package Geo::GoogleEarth::Pluggable::Folder;
use base qw{Geo::GoogleEarth::Pluggable::Base}; 
use XML::LibXML::LazyBuilder qw{E};
use warnings;
use strict;

use Module::Pluggable search_path => "Geo::GoogleEarth::Pluggable::Plugin";
use base qw{Method::Autoload};

use Geo::GoogleEarth::Pluggable::NetworkLink;

our $VERSION ='0.06';

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

=head2 initialize

We overide the default "initialize" method in order to append the "plugins" method from L<Module::Pluggable> on to the packages list of the L<Method::Autoload> package.

The "packages" property is what is needed by L<Method::Autoload> package.  The "plugins" method is what is provided by L<Module::Pluggable>.  So, the Folder package now has available to it every method in the "Plugins" folder at runtime.

=cut

sub initialize {
  my $self = shift();
  %$self=@_;
  $self->pushPackages($self->plugins); 
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

=head2 node

=cut

sub node {
  my $self=shift;
  my @element=();
  push @element, E(name=>{}, $self->name);
  foreach my $obj ($self->data) {
    push @element, $obj->node;
  }
  return E(Folder=>{}, @element);
}

=head2 data

Pushes arguments onto data array and returns an array or reference that holds folder object content.  This is a list of objects that supports a type and structure method.

  my $data=$folder->data;
  my @data=$folder->data;
  $folder->data($placemark);

=cut

sub data {
  my $self=shift();
  $self->{'data'} = [] unless ref($self->{'data'}) eq "ARRAY";
  my $data=$self->{'data'};
  if (@_) {
    push @$data, @_;
  }
  return wantarray ? @$data : $data;
}

=head2 document

=cut

sub document {
  my $self=shift;
  return $self->{"document"};
}

=head2 open

=cut

sub open {shift->{"open"}};

=head1 BUGS

Please log on RT and send to the geo-perl email list.

=head1 LIMITATIONS

Due to limitations in Perl hashes, it is not possible to specify the order of certain elements and attributes in the XML.

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

L<Geo::GoogleEarth::Pluggable>, L<Module::Pluggable> L<Method::Autoload>, L<XML::LibXML::LazyBuilder>

=cut

1;
