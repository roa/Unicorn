#!/usr/bin/perl

use 5.010;
use feature 'say';
use strict;
use warnings;
use lib 'lib';
use Unicorn::Manager::Version;
use File::Slurp 'edit_file';

my $old_version = qx[awk '/^Version/ {print \$2}' \$(find lib/ -name Version.pm)];
chomp $old_version;

my $version = Unicorn::Manager::Version->get;

my @files = qx[grep $old_version -l \$(find -iname *.p?)];

for (@files){
    chomp;
    edit_file { s/$old_version/$version/g } $_;
}

say "bumped version from $old_version to $version";

exit 0;
