use Test::Dependencies
    exclude => [qw/Test::Dependencies Test::Base Test::Perl::Critic Plack::Middleware::Maintenance/],
    style   => 'light';
ok_dependencies();
