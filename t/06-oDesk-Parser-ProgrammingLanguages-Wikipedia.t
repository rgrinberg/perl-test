use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More;
use Test::Exception;
use Data::Dumper;

my $class = 'oDesk::Parser::ProgrammingLanguages::Wikipedia';
my $default_url = 'http://en.wikipedia.org/wiki/List_of_programming_languages';

my $expected_data = [
          'A# .NET',
          'A# (Axiom)',
          'A-0 System',
          'A+',
          'A++',
          'ABAP',
          'ABC',
          'ABC ALGOL',
          'ABLE',
          'ABSET',
          'ABSYS',
          'Abundance',
          'ACC',
          'Accent',
          'Ace DASL',
          'ACT-III',
          'Action!',
          'ActionScript',
          'Ada',
          'Adenine',
          'Agda',
          'Agilent VEE',
          'Agora',
          'AIMMS',
          'Alef',
          'ALF',
          'ALGOL 58',
          'ALGOL 60',
          'ALGOL 68',
          'Alice',
          'Alma-0',
          'AmbientTalk',
          'Amiga E',
          'AMOS',
          'AMPL',
          'APL',
          'AppleScript',
          'Arc',
          'ARexx',
          'Argus',
          'AspectJ',
          'ASP.NET',
          'Assembly language',
          'ATS',
          'Ateji PX',
          'AutoHotkey',
          'Autocoder',
          'AutoIt',
          'AutoLISP / Visual LISP',
          'Averest',
          'AWK',
          'Axum',
          'B',
          'Babbage',
          'BAIL',
          'Bash',
          'BASIC',
          'bc',
          'BCPL',
          'BeanShell',
          'Batch (Windows/Dos)',
          'Bertrand',
          'BETA',
          'Bigwig',
          'Bistro',
          'BitC',
          'BLISS',
          'Blue',
          'Bon',
          'Boo',
          'Boomerang',
          'Bourne shell',
          'BREW',
          'BPEL',
          'BUGSYS',
          'BuildProfessional',
          'C',
          'C--',
          'C++',
          'C#',
          'C/AL',
          "Cach\x{e9} ObjectScript",
          'C Shell',
          'Caml',
          'Candle',
          'Cayenne',
          'CDuce',
          'Cecil',
          'Cel',
          'Cesil',
          'Ceylon',
          'CFML',
          'Cg',
          'Ch',
          'Chapel',
          'CHAIN',
          'Charity',
          'Charm',
          'Chef',
          'CHILL',
          'CHIP-8',
          'chomski',
          'ChucK',
          'CICS',
          'Cilk',
          'CL',
          'Claire',
          'Clarion',
          'Clean',
          'Clipper',
          'CLIST',
          'Clojure',
          'CLU',
          'CMS-2',
          'COBOL',
          'CobolScript',
          'Cobra',
          'CODE',
          'CoffeeScript',
          'Cola',
          'ColdC',
          'ColdFusion',
          'Cool',
          'COMAL',
          'Combined Programming Language',
          'Common Intermediate Language',
          'Common Lisp',
          'COMPASS',
          'Component Pascal',
          'COMIT',
          'Constraint Handling Rules',
          'Converge',
          'Coral 66',
          'Corn',
          'CorVision',
          'Coq',
          'COWSEL',
          'CPL',
          'csh',
          'CSP',
          'Csound',
          'Curl',
          'Curry',
          'Cyclone',
          'Cython',
          'D',
          'DASL',
          'DASL',
          'Dart',
          'DataFlex',
          'Datalog',
          'DATATRIEVE',
          'dBase',
          'dc',
          'DCL',
          'Deesel',
          'Delphi',
          'DinkC',
          'DIBOL',
          'Dog',
          'Draco',
          'Dylan',
          'DYNAMO',
          'E',
          'E#',
          'Ease',
          'Easy PL/I',
          'EASYTRIEVE PLUS',
          'ECMAScript',
          'Edinburgh IMP',
          'EGL',
          'Eiffel',
          'ELAN',
          'Elixir',
          'Emacs Lisp',
          'Emerald',
          'Epigram',
          'Erlang',
          'es',
          'Escapade',
          'Escher',
          'ESPOL',
          'Esterel',
          'Etoys',
          'Euclid',
          'Euler',
          'Euphoria',
          'EusLisp Robot Programming Language',
          'CMS EXEC',
          'EXEC 2',
          'F',
          'F#',
          'Factor',
          'Falcon',
          'Fancy',
          'Fantom',
          'FAUST',
          'Felix',
          'Ferite',
          'FFP',
          "Fj\x{f6}lnir",
          'FL',
          'Flavors',
          'Flex',
          'FLOW-MATIC',
          'FOCAL',
          'FOCUS',
          'FOIL',
          'FORMAC',
          '@Formula',
          'Forth',
          'Fortran',
          'Fortress',
          'FoxBase',
          'FoxPro',
          'FP',
          'FPr',
          'Franz Lisp',
          'Frink',
          'F-Script',
          'FSProg',
          'G',
          'Game Maker Language',
          'GameMonkey Script',
          'GAMS',
          'GAP',
          'G-code',
          'Genie',
          'GDL',
          'Gibiane',
          'GJ',
          'GEORGE',
          'GLSL',
          'GNU E',
          'GM',
          'Go',
          'Go!',
          'GOAL',
          "G\x{f6}del",
          'Godiva',
          'GOM (Good Old Mad)',
          'Goo',
          'Gosu',
          'GOTRAN',
          'GPSS',
          'GraphTalk',
          'GRASS',
          'Groovy',
          'HAL/S',
          'Hamilton C shell',
          'Harbour',
          'Hartmann pipelines',
          'Haskell',
          'Haxe',
          'High Level Assembly',
          'HLSL',
          'Hop',
          'Hope',
          'Hugo',
          'Hume',
          'HyperTalk',
          'IBM Basic assembly language',
          'IBM HAScript',
          'IBM Informix-4GL',
          'IBM RPG',
          'ICI',
          'Icon',
          'Id',
          'IDL',
          'Idris',
          'IMP',
          'Inform',
          'Io',
          'Ioke',
          'IPL',
          'IPTSCRAE',
          'ISLISP',
          'ISPF',
          'ISWIM',
          'J',
          'J#',
          'J++',
          'JADE',
          'Jako',
          'JAL',
          'Janus',
          'JASS',
          'Java',
          'JavaScript',
          'JCL',
          'JEAN',
          'Join Java',
          'JOSS',
          'Joule',
          'JOVIAL',
          'Joy',
          'JScript',
          'JavaFX Script',
          'Julia',
          'K',
          'Kaleidoscope',
          'Karel',
          'Karel++',
          'Kaya',
          'KEE',
          'KIF',
          'Kojo',
          'KRC',
          'KRL',
          'KUKA',
          'KRYPTON',
          'ksh',
          'L',
          'L# .NET',
          'LabVIEW',
          'Ladder',
          'Lagoona',
          'LANSA',
          'Lasso',
          'LaTeX',
          'Lava',
          'LC-3',
          'Leadwerks Script',
          'Leda',
          'Legoscript',
          'LIL',
          'LilyPond',
          'Limbo',
          'Limnor',
          'LINC',
          'Lingo',
          'Linoleum',
          'LIS',
          'LISA',
          'Lisaac',
          'Lisp',
          'Lite-C',
          'Lithe',
          'Little b',
          'Logo',
          'Logtalk',
          'LPC',
          'LSE',
          'LSL',
          'LiveCode',
          'Lua',
          'Lucid',
          'Lustre',
          'LYaPAS',
          'Lynx',
          'M',
          'M2001',
          'M4',
          'Machine code',
          'MAD',
          'MAD/I',
          'Magik',
          'Magma',
          'make',
          'Maple',
          'MAPPER',
          'MARK-IV',
          'Mary',
          'MASM Microsoft Assembly x86',
          'Mathematica',
          'MATLAB',
          'Maxima',
          'Max',
          'MaxScript',
          'Maya (MEL)',
          'MDL',
          'Mercury',
          'Mesa',
          'Metacard',
          'Metafont',
          'MetaL',
          'Microcode',
          'MicroScript',
          'MIIS',
          'MillScript',
          'MIMIC',
          'Mirah',
          'Miranda',
          'MIVA Script',
          'ML',
          'Moby',
          'Model 204',
          'Modelica',
          'Modula',
          'Modula-2',
          'Modula-3',
          'Mohol',
          'MOO',
          'Mortran',
          'Mouse',
          'MPD',
          'CIL',
          'MSL',
          'MUMPS',
          'Napier88',
          'NASM',
          'NATURAL',
          'Neko',
          'Nemerle',
          'NESL',
          'Net.Data',
          'NetLogo',
          'NetRexx',
          'NewLISP',
          'NEWP',
          'Newspeak',
          'NewtonScript',
          'NGL',
          'Nial',
          'Nice',
          'Nickle',
          'NPL',
          'Not eXactly C',
          'Not Quite C',
          'Nu',
          'NSIS',
          'NWScript',
          'o:XML',
          'Oak',
          'Oberon',
          'Obix',
          'OBJ2',
          'Object Lisp',
          'ObjectLOGO',
          'Object REXX',
          'Object Pascal',
          'Objective-C',
          'Objective-J',
          'Obliq',
          'Obol',
          'OCaml',
          'occam',
          "occam-\x{3c0}",
          'Octave',
          'OmniMark',
          'Onyx',
          'Opa',
          'Opal',
          'OpenEdge ABL',
          'OPL',
          'OPS5',
          'OptimJ',
          'Orc',
          'ORCA/Modula-2',
          'Oriel',
          'Orwell',
          'Oxygene',
          'Oz',
          'P#',
          'PARI/GP',
          'Pascal',
          'Pawn',
          'PCASTL',
          'PCF',
          'PEARL',
          'PeopleCode',
          'Perl',
          'PDL',
          'PHP',
          'Phrogram',
          'Pico',
          'Pict',
          'Pike',
          'PIKT',
          'PILOT',
          'Pipelines',
          'Pizza',
          'PL-11',
          'PL/0',
          'PL/B',
          'PL/C',
          'PL/I',
          'PL/M',
          'PL/P',
          'PL/SQL',
          'PL360',
          'PLANC',
          "Plankalk\x{fc}l",
          'PLEX',
          'PLEXIL',
          'Plus',
          'POP-11',
          'PostScript',
          'PortablE',
          'Powerhouse',
          'PowerBuilder',
          'PowerShell',
          'PPL',
          'Processing',
          'Processing.js',
          'Prograph',
          'PROIV',
          'Prolog',
          'Visual Prolog',
          'Promela',
          'PROTEL',
          'ProvideX',
          'Pro*C',
          'Pure',
          'Python',
          'Q (equational programming language)',
          'Q (programming language from Kx Systems)',
          'Qalb',
          'QBasic',
          'Qi',
          'Qore',
          'QtScript',
          'QuakeC',
          'QPL',
          'R',
          'R++',
          'Racket',
          'RAPID',
          'Rapira',
          'Ratfiv',
          'Ratfor',
          'rc',
          'REBOL',
          'Red',
          'Redcode',
          'REFAL',
          'Reia',
          'Revolution',
          'rex',
          'REXX',
          'Rlab',
          'ROOP',
          'RPG',
          'RPL',
          'RSL',
          'RTL/2',
          'Ruby',
          'Rust',
          'S',
          'S2',
          'S3',
          'S-Lang',
          'S-PLUS',
          'SA-C',
          'SabreTalk',
          'SAIL',
          'SALSA',
          'SAM76',
          'SAS',
          'SASL',
          'Sather',
          'Sawzall',
          'SBL',
          'Scala',
          'Scheme',
          'Scilab',
          'Scratch',
          'Script.NET',
          'Sed',
          'Seed7',
          'Self',
          'SenseTalk',
          'SequenceL',
          'SETL',
          'Shift Script',
          'SIMPOL',
          'SIMSCRIPT',
          'Simula',
          'Simulink',
          'SISAL',
          'SLIP',
          'SMALL',
          'Smalltalk',
          'Small Basic',
          'SML',
          'SNOBOL',
          'Snowball',
          'SOL',
          'Span',
          'SPARK',
          'SPIN',
          'SP/k',
          'SPS',
          'Squeak',
          'Squirrel',
          'SR',
          'S/SL',
          'Starlogo',
          'Strand',
          'Stata',
          'Stateflow',
          'Subtext',
          'SuperCollider',
          'SuperTalk',
          'SYMPL',
          'SyncCharts',
          'SystemVerilog',
          'T',
          'TACL',
          'TACPOL',
          'TADS',
          'TAL',
          'Tcl',
          'Tea',
          'TECO',
          'TELCOMP',
          'TeX',
          'TEX',
          'TIE',
          'Timber',
          'TMG',
          'Tom',
          'TOM',
          'Topspeed',
          'TPU',
          'Trac',
          'TTM',
          'T-SQL',
          'TTCN',
          'Turing',
          'TUTOR',
          'TXL',
          'TypeScript',
          'Ubercode',
          'UCSD Pascal',
          'Unicon',
          'Uniface',
          'UNITY',
          'Unix shell',
          'UnrealScript',
          'Vala',
          'VBA',
          'VBScript',
          'Verilog',
          'VHDL',
          'Visual Basic',
          'Visual Basic .NET',
          'Microsoft Visual C++',
          'Visual C#',
          'Visual DataFlex',
          'Visual DialogScript',
          'Visual Fortran',
          'Visual FoxPro',
          'Visual J++',
          'Visual J#',
          'Visual Objects',
          'VSXu',
          'Vvvv',
          'WATFIV, WATFOR',
          'WebDNA',
          'WebQL',
          'Windows PowerShell',
          'Winbatch',
          'X++',
          'X#',
          'X10',
          'XBL',
          'XC',
          'xHarbour',
          'XL',
          'XOTcl',
          'XPL',
          'XPL0',
          'XQuery',
          'XSB',
          'XSLT',
          'Yorick',
          'YQL',
          'Z notation',
          'Zeno',
          'ZOPL',
          'ZPL'
        ];

my $expected_anagrams = [
          'CPL',
          'DASL',
          'DASL',
          'LISA',
          'LPC',
          'MSL',
          'SAIL',
          'SML'
        ];

use_ok($class);

{
  my $parser = $class->new;
  isa_ok($parser, $class);

  # test default value of 'url' attribute
  cmp_ok($parser->url, 'eq', $default_url, 'default url attribute');
}

{
  my $google_url = 'http://www.google.com';

  my $parser = $class->new(url => $google_url);
  isa_ok($parser, $class);

  cmp_ok($parser->url, 'eq', $google_url, 'passed url attribute');
}


{
  my $parser = $class->new;

  my $aref = $parser->get_data;
  cmp_ok(ref $aref, 'eq', 'ARRAY', 'get_data - scalar context');

  my @array = $parser->get_data;
  is_deeply(\@array, $expected_data, 'get_data - list context');
}

# BONUS POINTS - get_anagrams
# if you want to write this method, uncomment this test case
{
  my $parser = $class->new;
  
  my $aref = $parser->get_anagrams;

  is_deeply([sort @$aref], [sort @$expected_anagrams], 'get_anagrams');
}

done_testing();
