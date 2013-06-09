use strict;
use warnings;
package oDesk::Model::Skill;
use Moose;
use namespace::autoclean;

has db => ( is => 'ro', required => 1);

sub get_all_hashref {
    my $self = shift;
    my $arr = $self->db->dbh->selectcol_arrayref('select * from skill',
        { Columns => [1,2] });
    my %mapping = @$arr;
    return \%mapping;
}

sub get_skill_names {
    my $self = shift;
    my $skill_names = $self->db->dbh->
        selectcol_arrayref('select name from skill order by name asc');
    return @$skill_names if wantarray();
    return $skill_names;
}

sub get_name_for_id {
    my ($self, $id) = @_;
    my $sth = $self->db->dbh->prepare('select name from skill where id=?');
    $sth->execute($id);
    while( my @row = $sth->fetchrow_array ) {
        return $row[0];
    }
}

sub get_id_for_name {
    my ($self, $name) = @_;
    my $sth = $self->db->dbh->prepare('select id from skill where name=?');
    $sth->execute($name);
    while( my @row = $sth->fetchrow_array ) {
        return $row[0];
    }
}

__PACKAGE__->meta->make_immutable;
1;
