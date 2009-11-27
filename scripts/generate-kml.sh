#!/usr/bin/perl
use strict;

while (my $file=shift) {
  next unless -r $file;
  print qx{perl -Mblib $file > "$file.kml"};
}

