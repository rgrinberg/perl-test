use strict;
use warnings;
package oDesk::Model::Country;
use Moose;
use namespace::autoclean;

has db => ( is => 'ro', required => 1);

__PACKAGE__->meta->make_immutable;
1;
