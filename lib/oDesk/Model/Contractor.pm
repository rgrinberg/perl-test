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
    [ map { 
        my $contractor = $self->new(db => $self->db);
        $contractor->populate($_);
    } @$all ];
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
