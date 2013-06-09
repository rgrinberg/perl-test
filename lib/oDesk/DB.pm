use warnings;
use strict;
package oDesk::DB;
# ABSTRACT: db model class
use MooseX::Singleton;
use namespace::autoclean;
use DBI;
use oDesk::Config;

has dbh => (
    is => 'ro',
    default => sub {
        my $db_path = oDesk::Config->new()->db_path();
        DBI->connect(
            "dbi:SQLite:dbname=$db_path", {
                # mostly to ease debugging, we would not want to print
                # this stuff in production
                PrintError => 1,
                RaiseError => 1,
                AutoCommit => 1,
            });
    }
);

__PACKAGE__->meta->make_immutable;

1;

