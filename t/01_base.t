use Test::More;
use warnings;
use strict;
use lib './t/lib';
use_ok('TestApp::Home');


{
    my $path = TestApp::Home->get();
    like($path->stringify,qr/\/t$/);
}

{
    my $path = TestApp::Home->get();
    like($path->stringify,qr/\/t$/);
}

{
    my $path = TestApp::Home->instance();
    like($path->stringify,qr/\/t$/);
}
done_testing();
