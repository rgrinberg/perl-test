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
has skills      => ( is => 'rw', isa => 'Array[Int]' );

sub create {
    my $self = shift;
}

sub update {
    my $self = shift;
}

sub load {
    my ($self, $id) = @_;
}

sub delete {
    my ($self, $id) = @_;
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
