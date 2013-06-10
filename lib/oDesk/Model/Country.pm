use strict;
use warnings;
package oDesk::Model::Country;
use Moose;
use namespace::autoclean;

has db => ( is => 'ro', required => 1);

sub get_all_hashref {
    my $self = shift;
    my $arr = $self->db->dbh->selectcol_arrayref('select * from country',
        { Columns => [1,2] });
    my %mapping = @$arr;
    return \%mapping;
}

sub get_country_names {
    my $self = shift;
    my $country_names = $self->db->dbh->
        selectcol_arrayref('select name from country order by name asc');
    return @$country_names if wantarray();
    return $country_names;
}

sub get_name_for_id {
    my ($self, $id) = @_;
    my $sth = $self->db->dbh->prepare('select name from country where id=?');
    $sth->execute($id);
    while( my @row = $sth->fetchrow_array ) {
        return $row[0];
    }
}

sub get_id_for_name {
    my ($self, $name) = @_;
    my $sth = $self->db->dbh->prepare('select id from country where name=?');
    $sth->execute($name);
    while( my @row = $sth->fetchrow_array ) {
        return $row[0];
    }
}

__PACKAGE__->meta->make_immutable;
1;
=pod

=head1 NAME

oDesk::Model::Country

=head1 SYNOPSIS

  use oDesk::DB;
  use ODesk::Model::Country;

  my $db = oDesk::DB->new;
  my $model = oDesk::Model::Country->new(db => $db);
  # print all the country names
  foreach my $country ($model->get_country_names) {
    print "Country: $country\n";
  }

=head1 INTRODUCTION

class representing the models for countries

=head1 METHODS

=head2 get_all_hashref 

returns a hashref that maps all the country id's in the database to their
respective country names

=head2 get_country_names 

Returns an arrayref to all the country names in scalar context. Just
returns the array in array context

=head2 get_name_for_id 

$c->get_name_for_id($id) returns the name of the country corresponding
to id:$id

=head2 get_id_for_name 

$c->get_id_for_name($id) returns the id of the country corresponding
to name: $name

=head1 AUTHOR

Rudi Grinberg <rudi.grinberg@gmail.com>

=cut
