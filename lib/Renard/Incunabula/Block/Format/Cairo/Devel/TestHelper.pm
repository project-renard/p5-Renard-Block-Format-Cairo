use Renard::Incunabula::Common::Setup;
package Renard::Incunabula::Block::Format::Cairo::Devel::TestHelper;
# ABSTRACT: A test helper with functions useful for testing Cairo documents

use Renard::Incunabula::Block::Format::Cairo::ImageSurface::Document;
use Cairo;

=classmethod create_cairo_document

  Renard::Incunabula::Block::Format::Cairo::Devel::TestHelper->create_cairo_document

Returns a L<Renard::Incunabula::Block::Format::Cairo::ImageSurface::Document> which can be
used for testing.

The pages have the colors:

=for :list

* red

* green

* blue

* black

=cut
classmethod create_cairo_document( :$repeat = 1, :$width = 5000, :$height = 5000 ) {
	my $colors = [
		(
			[ 1, 0, 0 ],
			[ 0, 1, 0 ],
			[ 0, 0, 1 ],
			[ 0, 0, 0 ],
		) x ( $repeat )
	];

	my @surfaces = map {
		my $surface = Cairo::ImageSurface->create(
			'rgb24', $width, $height
		);
		my $cr = Cairo::Context->create( $surface );

		my $rgb = $_;
		$cr->set_source_rgb( @$rgb );
		$cr->rectangle(0, 0, $width, $height);
		$cr->fill;

		$surface;
	} @$colors;

	my $cairo_doc = Renard::Incunabula::Block::Format::Cairo::ImageSurface::Document->new(
		image_surfaces => \@surfaces,
	);
}

1;
