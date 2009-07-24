#!/usr/bin/perl -T

# t/01manifest.t
#  Ensures MANIFEST file is up-to-date
#
# $Id$

use strict;
use warnings;

use Test::More;

unless ($ENV{AUTOMATED_TESTING} or $ENV{RELEASE_TESTING}) {
  plan skip_all => 'Author tests not required for installation';
}

my %MODULES = (
  'Test::DistManifest'  => 1.002002,
  'Module::Manifest'    => 0.07,
);

while (my ($module, $version) = each %MODULES) {
  eval "use $module $version";
  next unless $@;

  if ($ENV{RELEASE_TESTING}) {
    die 'Failed to load required release-testing module ' . $module;
  }
  else {
    plan skip_all => $module . ' not available for testing';
  }
}

manifest_ok();
