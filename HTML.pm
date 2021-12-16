package Plack::App::Tags::HTML;

use base qw(Plack::Component::Tags::HTML);
use strict;
use warnings;

use English;
use Error::Pure qw(err);
use Plack::Util::Accessor qw(component constructor_args data);

our $VERSION = 0.01;

sub _css {
	my $self = shift;

	$self->{'_component'}->process_css;

	return;
}

sub _prepare_app {
	my $self = shift;

	my %p = (
		'css' => $self->css,
		'tags' => $self->tags,
	);

	my $component = $self->component;
	eval "require $component;";
	if ($EVAL_ERROR) {
		err "Cannot load component '$component'.",
			'Error', $EVAL_ERROR;
	}
	$self->{'_component'} = $component->new(
		%p,
		%{$self->constructor_args},
	);

	return;
}

sub _tags_middle {
	my $self = shift;

	$self->{'_component'}->process($self->data);

	return;
}

1;

__END__
