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

=pod

=head1 NAME

oDesk::DB

=head1 SYNOPSIS

  use oDesk::DB;
  # creates a db instance
  my $db = oDesk::DB->new;
  # since $db is a singleton
  my $db2 = oDesk::DB->new;
  # this means that $db and $db2 are exactly the same

=head1 INTRODUCTION

Singleton that encapsulates the dbi connection to the database in the dbh
field

=head1 METHODS

=head2 dbh

  my $dbh = $db->$dbh;

returns the DBI connection handle to the database

=head1 AUTHOR

Rudi Grinberg <rudi.grinberg@gmail.com>

=cut
