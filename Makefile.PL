
use strict;
use warnings;



use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'SQL-Abstract-Plugin-InsertReturning',
  NAME      => 'SQL::Abstract::Plugin::InsertReturning',
  AUTHOR    => "Oliver\ Charles\ \<oliver\.g\.charles\@googlemail\.com\>",
  ABSTRACT  => "Augment\ SQL\:\:Abstract\-\>insert\ with\ support\ for\ returning\ data",
  VERSION   => '0.01',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => '') : ()),
  PREREQ_PM    => {
    "Sub::Exporter" => '0',
  },
  test => {TESTS => 't/*.t'}
);

