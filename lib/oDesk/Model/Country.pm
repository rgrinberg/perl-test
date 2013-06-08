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
