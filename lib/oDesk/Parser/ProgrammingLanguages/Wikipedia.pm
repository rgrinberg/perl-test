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
sub get_data {
    my $self = shift;
    my $ua = LWP::UserAgent->new;
    my $tree = HTML::TreeBuilder::XPath->new;
    my $content = $ua->get($self->url)->decoded_content;
    $tree->parse($content);
    my @langs = $tree->findvalues('//table[@class="multicol"]//ul/li/a[1]');
    $tree->delete;
    return @langs if wantarray();
    return \@langs;
}
1;
