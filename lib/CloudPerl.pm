package CloudPerl;
use Moose;
use Bread::Board::Declare;

use Plack::Builder;
use Plack::Middleware::Magpie;

has resources => (
    isa   => 'HashRef',
    is    => 'ro',
    block => sub {
        {
            '/'     => 'CloudPerl::Resource::Default',
            '/user' => 'CloudPerl::Resource::User',
        };
    }
);

has app => (
    reader => 'to_app',
    block  => sub {
        my ($s)       = @_;
        my $resources = $s->param('resources');
        my $urlmap    = Plack::App::URLMap->new;
        for my $path ( keys %$resources ) {
            $urlmap->map(
                $path => builder {
                    enable "Magpie", resource => $resources->{$path};
                }
            );
        }
        return $urlmap->to_app;
    },
    dependencies => ['resources'],
);

1;
__END__
