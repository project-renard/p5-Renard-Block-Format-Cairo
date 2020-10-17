use Renard::Incunabula::Common::Setup;
package Renard::Incunabula::Page::Role::CairoRenderableFromPNG;
# ABSTRACT: A role to use PNG data to create Cairo::ImageSurface

use Moo::Role;
use Cairo;

use Renard::Incunabula::Common::Types qw(Str InstanceOf Int);

=attr png_data

A binary C<Str> which contains the PNG data that represents this page.

=cut
has png_data => (
	is => 'rw',
	isa => Str,
	required => 1
);

has cairo_image_surface => (
	is => 'lazy', # _build_cairo_image_surface
);

method _build_cairo_image_surface() :ReturnType(InstanceOf['Cairo::ImageSurface']) {
	# read the PNG data in-memory
	my $img = Cairo::ImageSurface->create_from_png_stream(
		my $cb = fun ((Str) $callback_data, (Int) $length) {
			state $offset = 0;
			my $data = substr $callback_data, $offset, $length;
			$offset += $length;
			$data;
		}, $self->png_data );

	return $img;
}

with qw(
	Renard::Incunabula::Page::Role::CairoRenderable
);

1;
