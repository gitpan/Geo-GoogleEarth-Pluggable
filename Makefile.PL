

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Geo::GoogleEarth::Pluggable',
    VERSION_FROM => 'lib/Geo/GoogleEarth/Pluggable.pm', # finds \$VERSION
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT     => 'Generates GoogleEarth Documents',
    PREREQ_PM    => {
                     'Test::Simple'             => 0.44,
                     'Scalar::Util'             => 0,
                     'IO::Scalar'               => 0,
                     'XML::LibXML::LazyBuilder' => 0,
                     'Archive::Zip'             => 0,
                     'Method::Autoload'         => 0,
                     'Module::Pluggable'        => 0,
                     'strict'                   => 0,
                     'warnings'                 => 0,
                     'base'                     => 0,
                    },
);
