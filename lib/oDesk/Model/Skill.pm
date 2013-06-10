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
=pod

=head1 NAME

oDesk::Model::Skill

=head1 SYNOPSIS

  use oDesk::DB;
  use ODesk::Model::Skill;

  my $db = oDesk::DB->new;
  my $model = oDesk::Model::Skill->new(db => $db);
  
  # print all skills
  printf "$skill\n" foreach my $skill ($model->get_skill_names);


=head1 INTRODUCTION

class representing the model for contractor skills

=head1 METHODS

=head2 get_all_hashref 

returns a hashref that maps all the skill id's in the database to their
respective skill names

=head2 get_skill_names 

Returns an arrayref to all the skill names in scalar context. Just
returns the array in array context

=head2 get_name_for_id 

$c->get_name_for_id($id) returns the name of the skill corresponding
to id:$id

=head2 get_id_for_name 

$c->get_id_for_name($id) returns the id of the skill corresponding
to name: $name

=head1 AUTHOR

Rudi Grinberg <rudi.grinberg@gmail.com>

=cut
