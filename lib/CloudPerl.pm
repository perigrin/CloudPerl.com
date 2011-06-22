package CloudPerl;
use Moose;

use Plack::Builder;
use Plack::Middleware::Magpie;

sub to_app {
    builder {
        mount '/' => builder {
            enable "Magpie", resource => 'CloudPerl::Resource::Default';
        };
        mount '/user' => builder {
            enable "Magpie", resource => 'CloudPerl::Resource::User';
        };
    };
}

1;
__END__
