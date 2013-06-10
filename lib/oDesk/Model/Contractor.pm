use strict;
use warnings;
package oDesk::Model::Contractor;
use Moose;
use namespace::autoclean;

has db          => ( is => 'ro', required => 1);
has id          => ( is => 'rw' );
has first_name  => ( is => 'rw' );
has last_name   => ( is => 'rw' );
has hourly_rate => ( is => 'rw' );
has country_id  => ( is => 'rw', isa => 'Int' );

sub create {
    my $self = shift;
    my %contractor = @_;
    my $sth = $self->db->dbh->prepare('
        insert into
        contractor(country_id, first_name, last_name, hourly_rate)
        values(?,?,?,?)'
    );
    $sth->execute($contractor{country_id}, $contractor{first_name},
        $contractor{last_name}, $contractor{hourly_rate});
    $self->load($self->db->dbh->last_insert_id(undef, undef, undef, undef));
    return $self->id;
}

sub update {
    my $self = shift;
    $self->db->dbh->do(
        'update contractor
        set country_id=?, first_name=?, last_name=?, hourly_rate=?
        where id=?',
        undef, $self->country_id, $self->first_name, $self->last_name,
        $self->hourly_rate, $self->id,
    );
}

sub populate {
    my ($self, $contractor) = @_;
    $self->id($contractor->{id});
    $self->first_name($contractor->{first_name});
    $self->last_name($contractor->{last_name});
    $self->country_id($contractor->{country_id});
    $self->hourly_rate($contractor->{hourly_rate});
    return $self;
}

sub load {
    my ($self, $id) = @_;
    my $contractor = $self->db->dbh->selectrow_hashref('
        select * from contractor where id=?', undef, $id);
    $self->populate($contractor);
    return $self;
}

sub delete {
    my ($self, $id) = @_;
    printf "deleting $id\n";
    $self->db->dbh->do('delete from contractor where id=?', undef, $id);
}

sub get_all {
    my $self = shift;
    my $all = $self->db->dbh->selectall_arrayref('select * from contractor',
        { Slice => {} });
    map { 
        my $contractor = $self->new(db => $self->db);
        $contractor->populate($_);
    } @$all;
}

sub get_skills {
    my $self = shift;
    return @{$self->db->dbh->selectcol_arrayref(
        'select skill_id from contractor_skill where contractor_id=?',
        undef, $self->id
    )};
}

sub add_skill {
    my ($self, $skill_id) = @_;
    $self->db->dbh->do(
        'insert into contractor_skill(contractor_id, skill_id) values(?,?)',
        undef, $self->id, $skill_id);
}

sub delete_skill {
    my ($self, $skill_id) = @_;
    $self->db->dbh->do(
        'delete from contractor_skill where contractor_id=? and skill_id=?',
        undef, $self->id, $skill_id);
}

sub get_common_skills {
    my ($self, $c1, $c2) = @_;
    @{$self->db->dbh->selectcol_arrayref('
        select skill_id from contractor_skill where contractor_id=?
        intersect
        select skill_id from contractor_skill where contractor_id=?',
        undef, $c1->id, $c2->id)
    };
}

__PACKAGE__->meta->make_immutable;
1;
=pod

=head1 NAME

oDesk::Model::Contractor

=head1 SYNOPSIS

  use oDesk::DB;
  use ODesk::Model::Contractor;

  my $db = oDesk::DB->new;
  my $model = oDesk::Model::Contractor->new(db => $db);
  # create a contractor:
  my $contractor_id = $model->create(
    first_name  => 'John',
    last_name   => 'Smith',
    hourly_rate => '20.22',
    country_id  => $country_id,
  );

  # now delete
  $model->delete($contractor_id);

  # count the number of contractors
  my $total_countractors = scalar($model->get_all);

=head1 INTRODUCTION

class representing the contractors

=head1 FIELDS

=head2 id

id of contractor

=head2 first_name

first name of contractor

=head2 last_name

last name of contractor

=head2 hourly_rate

hourly_rate of a contractor

=head2 country_id

the country id of the origin country of a contractor

=head1 METHODS

=head2 create

$contractor->create(%contractor) creates a new contractor and returns its id.
%contractor must contain the key value pairs corresponding to the fields.

=head2 update

updates the contractor record in the database using the current data in the
object

=head2 load

$contractor->load($id) returns a contractor object corresponding to the
contractor in the database with id $id.

=head2 delete

$contractor->delete($id) deletes the contractor with id $id from the database

=head2 get_all

$contractor->get_all() returns a list of all the contractors in the database.
every element in the list is a contractor object

=head2 get_skills

$contrctor->get_skills returns a list of skill ids of the skills that
the contractor posses

=head2 add_skill

$contractor->add_skill($skill_id) adds the skill corresponding to $skill_id 
to the $contractor skillset

=head2 delete_skill

$contractor->delete_skill($skill_id) removes the skill corresponding to $skill_id
from the $contractor's skill set.

=head2 get_common_skills

$contractor->get_common_skills($c1, $c2) returns a list of skill ids
that the contractors $c1 and $c2 have in common

Rudi Grinberg <rudi.grinberg@gmail.com>

=cut
