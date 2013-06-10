use strict;
use warnings;
package oDesk::Parser::ProgrammingLanguages::Wikipedia;
use Math::Prime::TiedArray; # extremely lazy, I know...
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

has user_agent => (
    is => 'ro',
    default => sub { LWP::UserAgent->new; }
);

has primes => (
    is => 'ro',
    default => sub {
        my @primes;
        tie @primes, 'Math::Prime::TiedArray';
        return \@primes;
    }
);

sub get_data {
    my $self = shift;
    my $tree = HTML::TreeBuilder::XPath->new;
    my $content = $self->user_agent->get($self->url)->decoded_content;
    $tree->parse_content($content);
    my @langs = $tree->findvalues('//table[@class="multicol"]//ul/li/a[1]');
    $tree->delete;
    return @langs if wantarray();
    return \@langs;
}


# if $w1 is an anagram of $w2 then encode_anagram($w1) eq encode_anagram($w2)
sub encode_anagram {
    # every word has a unique representation as an anagram obtained by 
    # mapping every character in the word to a different prime number
    # and the signature is then the product of those primes.
    # Uniqueness is guranteed by the prime factorization theorem.
    my ($self, $str) = @_;
    my $total = 1;
    for (split //, $str) {
        $total *= $self->primes->[ord $_];
    }
    return $total;
}

# Performance in the worst case should be O(n * m) where 
# n - the number of words analyzing in total
# m - the average length of each word
# Space complexity is also O(n * m)
sub get_anagrams {
    my $self = shift;
    my @data = $self->get_data;
    my %anagrams = (); # keep track of encodings map to anagrams
    # mapping of encoding to a list of anagrams
    my %words = ();
    foreach my $lang (@data) {
        my $enc = $self->encode_anagram($lang);
        if (exists $words{$enc}) {
            push @{$words{$enc}}, $lang;
            $anagrams{$enc} = 1;
        } else {
            $words{$enc} = [$lang];
        }
    }
    # get a list of all anagrams signatures that have more than 1 word
    my @anagram_encodings = keys %anagrams;
    # now extract all the words for every sig and join the list into 1
    return [ map { @$_ } @words{@anagram_encodings} ];
}

__PACKAGE__->meta->make_immutable;
1;


=pod

=head1 NAME

oDesk::Parser::ProgrammingLanguages::Wikipedia

=head1 SYNOPSIS

  use oDesk::DB;
  use ODesk::Model::Country;

  my $parser = $oDesk::Parser::ProgrammingLanguages::Wikipedia->new;

  # will return all programming languages from wikipedia
  my @langs = $parser->get_data;

=head1 INTRODUCTION

class that fetches programming languages from a url (wikipedia by default)

=head1 METHODS

=head2 get_data 

$parser->get_data() returns a list of all programming languages fetched
from $parser->url() in list context. In scalar context it returns a reference
to that same list

=head2 get_anagrams 

$parser->get_anagrams returns a list of all programming languages fetched
from $parser->url() that are anagrams.

=head1 AUTHOR

Rudi Grinberg <rudi.grinberg@gmail.com>

=cut
