package Plack::Middleware::Maintenance;
use strict;
use warnings;
use parent qw/Plack::Middleware/;

use Path::Class ();
use Plack::Util;
use Plack::Util::Accessor qw( file );

our $VERSION = '0.01';

sub call {
    my $self = shift;
    my $env  = shift;

    my $maintenance_file = Path::Class::file( $self->file );
    if ( -e $maintenance_file ) {
        return $self->_serve_maintenance_file($maintenance_file);
    }
    else {
        return $self->app->($env);
    }
}

sub _serve_maintenance_file {
    my ( $self, $file ) = @_;

    my $stat = $file->stat;
    my $fh   = $file->openr;

    return [
        503,
        [   'Content-Type'   => 'text/html',
            'Content-Length' => $stat->size,
        ],
        $fh,
    ];
}

1;

__END__

=encoding utf-8

=head1 NAME

Plack::Middleware::Maintenance -  a middleware to detect the existence of a maintenance.html page and display that instead of incoming requests. 

=head1 SYNOPSIS

  use Plack::Builder;

  builder {
      enable "Plack::Middleware::Maintenance", file => './public/maintenance.html';
      $app;
  };

=head1 DESCRIPTION

Plack::Middleware::Maintenance is a middleware to detect the existence of a maintenance.html 
page and display that instead of incoming requests. 

=head1 SOURCE AVAILABILITY

This source is in Github:

  http://github.com/dann/

=head1 AUTHOR

Takatoshi Kitano E<lt>kitano.tk@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
