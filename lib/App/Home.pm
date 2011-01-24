package App::Home;

use strict;
use warnings;
use parent qw(Class::Singleton);
use Path::Class;
our $VERSION = '0.01';


sub get {
    my $class = shift;
    $class->instance();
}

sub _new_instance {
    my $class = shift;
    die 'You can not use this module directory' if $class eq 'App::Home';
    my $self  = bless { }, $class;
    $self->_home();
}

sub _appname {
    my $self = shift;
    my $class = ref $self;
   if ( $class =~ m/^(.*?)::Home$/ ) {
        return $1; 
   }
   else {
        die 'module name must be end with ***::Home';
   }
}

sub _env_name {
    my( $self,$name, $appname ) = @_;
    $appname =~ s/::/_/g;
    return uc(join('_', $appname, $name));
}


sub _home {
    my $self = shift;
    my $class = ref $self;
    my $dir = $ENV{$self->_env_name('HOME',$self->_appname)} ;

    if($dir){
        return dir($dir);
    }

    # Steal code from Pickles::Config
    # https://github.com/ikebe/Pickles/blob/master/lib/Pickles/Config.pm
    (my $file = "$class.pm") =~ s|::|/|g;
    if (my $inc_path = $INC{$file}) {
        (my $path = $inc_path) =~ s/$file$//;
        my $home = dir($path)->absolute->cleanup;
        $home = $home->parent while $home =~ /b?lib$/;
        return $home;
    }
    die 'could not found home. please set up following env key value:.' . $self->_env_name('HOME',$self->_appname);
}

1;
__END__

=head1 NAME

App::Home -

=head1 SYNOPSIS

  pkackage YourApp::Home;
  use parent 'App::Home';
  1;

  use YourApp:Home;
  my $home = App::Home->get();

=head1 DESCRIPTION

App::Home does nothing but only find your application home directory.

=head1 METHODS

=head2 get()

 get home as Path::Class::Dir object.

=head1 ENV

=head2 YOURAPP_NAME_HOME

 you can set home path with setting $ENV with ***_HOME key.
 if your home package is YourApp::Name::Home then home env key is YOURAPP_NAME_HOME.

=head1 AUTHOR

Tomohiro Teranishi E<lt>tomohiro.teranishi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
