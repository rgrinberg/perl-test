# Just a few notes regarding my solution to this assignment


### To Moose or not to Moose

I elected to use Moose instead of traditional Perl OO for 2 reasons:
* I think it's great and I'm very comfortable with it
* Use of CPAN was encouraged.

That being said I'm also well versed with traditional Perl OO but
honestly a little rusty by now because I did not have to use it for such
a long time. On a real project I would of course use what the project
uses already. But I strongly recommend using Moose (or Mouse, Moo, etc.)


### Apologies In Advance

* I think I maintained a decent level of documentation but of course the level
of documentation that I output on a real project is much higher.

* Same goes for unit tests, I write much more of them on real projects :)

### Errata

* I've modified the tests for the last exercise for 2 reasons: The list
of programming languages was updated on wikipedia. The orignal test for
anagrams is sensitive to the order in which the anagrams are returned.
I'm assuming it's not part of the specification of the problem and hence
just normalized the order by sorting.

### Configuration

* I've added a Makefile to help me make changes to the schema etc. You
should run `$ make newdb` to regenerate the database with my altered
schema. before running any tests. Note: The schema is in `db/schema.sql`
while the data itself is in `db/data.sql`

* I'm accustomed to managing my Perl projects with Dist::Zilla but I know 
that not everyone is a fan of it. In case you're not a dzil user (I'm pretty
sure there are a few alternatives to it...) Then here's what you'd need to do

cpanm on the following modules should give you the dzil environment that I've
used. 

```
Dist::Zilla
Dist::Zilla::Plugin::AutoPrereqs
Dist::Zilla::Plugin::PodSyntaxTests
Dist::Zilla::Plugin::Test::Perl::Critic
Dist::Zilla::PluginBundle::Basic
```

As for the CPAN modules I've used you can ask dzil to create a list with:
```
$ dzil listdeps
# dzil listdeps | cpanm # just install the deps with dzil
```

On my system this outputs `dzil listdeps` gives in case you want to get these
modules manually:
```
Cwd
Data::Dumper
DBI
Encode
ExtUtils::MakeMaker
File::Slurp
FindBin
HTML::TreeBuilder::XPath
LWP::UserAgent
Math::Prime::TiedArray
Mock::Quick
Moose
MooseX::Singleton
namespace::autoclean
Test::Exception
Test::More
```

Then the following steps can create a traditional perl distribution.
You might have to run (dzil setup) if you've never used dzil before.

```
$ dzil test
$ dzil build
$ dzil install # optional
```

### Lastly

Cheers.
Rudi.
