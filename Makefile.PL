use inc::Module::Install;
name 'App-Home';
all_from 'lib/App/Home.pm';

requires 'parent';
requires 'Class::Singleton';
requires 'Path::Class';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
