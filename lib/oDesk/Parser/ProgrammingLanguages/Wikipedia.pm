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

# designate a unique prime number to every ascii character (techincally
# only the first 0..127 are designated as ascii characters so I over do it a
# little here). Also it would actually be better to assign a prime to every
# unicode character instead (lazily of course) but it doesn't seem to be 
# worth the effort for this toy

has char_encoding => (
    is => 'ro',
    default => sub {
        my @primes;
        tie @primes, 'Math::Prime::TiedArray';
        my %mapping = ();
        for (0..255) { # we actually don't need this many..
            $mapping{chr $_} = $primes[$_];
        };
        return \%mapping;
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

# if $w1 is an anagram of $w2 then encode_anagram($w1) eq encode_anagram($w2)
sub encode_anagram {
    # every word has a unique representation as an anagram obtained by 
    # mapping every character in the word to a different prime number
    # and the signature is then the product of those primes.
    # Uniqueness is guranteed by the prime factorization theorem.
    my ($self, $str) = @_;
    my $total = 1;
    for (split //, $str) {
        $total *= $self->char_encoding->{$_};
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
