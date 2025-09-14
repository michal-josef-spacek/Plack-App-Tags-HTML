use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use File::Object;
use Plack::App::Tags::HTML;
use Test::More 'tests' => 2;
use Test::NoWarnings;

unshift @INC, File::Object->new->up->dir('lib')->s;

# Test.
my $app = Plack::App::Tags::HTML->new(
	'component' => 'BadComponent',
);
eval {
	$app->to_app;
};
is($EVAL_ERROR, "Cannot load component 'BadComponent'.\n",
	"Cannot load component 'BadComponent' (Perl syntax error).");
clean;
