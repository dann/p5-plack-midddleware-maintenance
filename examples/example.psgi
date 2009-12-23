use Plack::Builder;

my $app = sub {
    return [
        200,
        [ "Content-Type" => "text/plain", "Content-Length" => 11 ],
        [ "Hello World" ],
    ];
};

builder {
    enable "Plack::Middleware::Maintenance", file => './examples/public/maintenance.html';
    $app;
};
