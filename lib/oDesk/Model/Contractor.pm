use strict;
use warnings;
package oDesk::Model::Skill;
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
        insert into contractor(country_id, first_name, last_name, hourly_rate)
        values(?,?,?,?)'
    );
    $sth->execute($contractor{country_id}, $contractor{first_name},
        $contractor{last_name}, $contractor{country_id});
    $self->load($self->db->dbh->last_insert_id());
    return $self->id;
}

sub update {
    my $self = shift;
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
    my $contractor = $self->dbh->selectrow_hashref('
        select * from contractor where id=?', undef, $id);
    $self->populate($contractor, undef);
    return $self;
}

sub delete {
    my ($self, $id) = @_;
    $self->db->dbh->do('delete from contractor where id=?', undef, $id);
}

sub get_all {
    my $self = shift;
}

sub get_skills {
    my $self = shift;
}

sub add_skill {
    my ($self, $skill_id) = @_;
    # TODO check for duplicate?
    push @{$self->skills}, $skill_id;
}

sub delete_skill {
    my ($self, $skill_id) = @_;
    $self->skills = grep { $_ != $skill_id } @{$self->skills};
    # TODO check if skill_id doesn't exist?
}

sub get_common_skills {
    my ($self, $c1, $c2) = @_;
    # TODO return an array of the skills ids common to both contractors
    return ()
}





__PACKAGE__->meta->make_immutable;
1;
