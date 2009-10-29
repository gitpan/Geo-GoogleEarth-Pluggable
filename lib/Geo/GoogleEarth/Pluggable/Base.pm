package Geo::GoogleEarth::Pluggable::Base;
use strict;
use warnings;

=head1 NAME

Geo::GoogleEarth::Pluggable::Base - Base for Geo::GoogleEarth::Pluggable::* packages

=head1 SYNOPSIS

  use base qw{Geo::GoogleEarth::Pluggable::Base};

=head1 DESCRIPTION

The is the base of all Geo::GoogleEarth::Pluggable packages.

=head1 USAGE

=head1 CONSTRUCTOR

=head2 new

  my $document = Geo::GoogleEarth::Pluggable->new(key1=>value1,
                                                  key2=>[value=>{opt1=>val1}],
                                                  key3=>{value=>{opt2=>val2}});

=cut

sub new {
  my $this = shift();
  my $class = ref($this) || $this;
  my $self = {};
  bless $self, $class;
  $self->initialize(@_);
  return $self;
}

=head1 METHODS

=cut

sub initialize {
  my $self = shift();
  %$self=@_;
}

=head1 document

Always returns the document object

=cut

sub document {
  my $self=shift;
  return $self->{"document"};
}

=head2 name

Sets or returns the name property.

  my $name=$folder->name;
  $placemark->name("New Name");
  $document->name("New Name");

=cut

sub name {
  my $self=shift;
  $self->{'name'}=shift if @_;
  return $self->{'name'};
}

=head2 description

Sets or returns the description property.

  my $description=$folder->description;
  $placemark->description("New Description");
  $document->description("New Description");

=cut

sub description {
  my $self=shift;
  $self->{'description'}=shift if @_;
  return $self->{'description'};
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
