use Renard::Incunabula::Common::Setup;
package Renard::Incunabula::Document::Role::Cacheable;
# ABSTRACT: Role that caches rendered pages

use Moo::Role;
use Renard::Incunabula::Common::Types qw(InstanceOf);

use CHI;

=attr render_cache

Holds an in-memory cache of the rendered pages.

See L<CHI> and L<CHI::Driver::RawMemory> for more information.

=cut
has render_cache => (
	is => 'lazy', # _build_render_cache
	isa => InstanceOf['CHI::Driver'],
);

sub _build_render_cache {
	CHI->new( driver => 'RawMemory', global => 0 );
}

=method get_rendered_page

  around get_rendered_page

A method modifier that caches the results of C<get_rendered_page>.

=cut
requires 'get_rendered_page';
around get_rendered_page => sub {
	my $orig = shift;
	my ($self, %rest) = @_;
	my @args = @_;

	# make sure to call in a scalar context
	my $return = $self->render_cache->compute(
		\%rest,
		'never',
		sub { $orig->(@args); }
	);

	$return;
};

1;
