use Test::More;
use warnings;
use strict;
use lib './t/lib';
use_ok('TestApp::Home');

$ENV{TESTAPP_HOME} = '/tmp';

{
    my $path = TestApp::Home->get();
    is($path->stringify,'/tmp' );
}

done_testing();
