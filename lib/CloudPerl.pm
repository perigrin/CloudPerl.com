package CloudPerl;
use Moose;

use Plack::Builder;
use Plack::Middleware::Magpie;

sub to_app {
    builder {
        enable "Magpie", resource => 'CloudPerl::Resource';
    };
}

1;
__END__
