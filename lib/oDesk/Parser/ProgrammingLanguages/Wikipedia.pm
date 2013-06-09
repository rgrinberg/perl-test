use strict;
use warnings;
package oDesk::Parser::ProgrammingLanguages::Wikipedia;
use Math::Prime::TiedArray;
use HTML::TreeBuilder::XPath;
use LWP::UserAgent;
use Moose;
use namespace::autoclean;

has url => (
    is => 'ro',
    default => sub {
        'http://en.wikipedia.org/wiki/List_of_programming_languages'
    },
);
1;
