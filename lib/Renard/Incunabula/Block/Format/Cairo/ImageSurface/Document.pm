use Renard::Incunabula::Common::Setup;
package Renard::Incunabula::Block::Format::Cairo::ImageSurface::Document;
# ABSTRACT: Document made up of a collection of Cairo image surfaces

use Moo;
use Renard::Incunabula::Page::CairoImageSurface;
use Function::Parameters;
use Renard::Incunabula::Common::Types qw(InstanceOf ArrayRef);
use Renard::Incunabula::Document::Types qw(PageNumber);

extends qw(Renard::Incunabula::Document);

=attr image_surfaces

An L<ArrayRef> of C<Cairo::ImageSurface>s which are the backing store of this
document.

=cut
has image_surfaces => (
	is => 'ro',
	isa => ArrayRef[InstanceOf['Cairo::ImageSurface']],
	required => 1
);

method _build_last_page_number() :ReturnType(PageNumber) {
	return scalar @{ $self->image_surfaces };
}

=method get_rendered_page

  method get_rendered_page( (PageNumber) :$page_number )

Returns a new L<Renard::Incunabula::Page::CairoImageSurface> object.

See L<Renard::Incunabula::Document::Role::Renderable/get_rendered_page> for more details.

=cut
method get_rendered_page( (PageNumber) :$page_number, @) {
	my $index = $page_number - 1;

	return Renard::Incunabula::Page::CairoImageSurface->new(
		page_number => $page_number,
		cairo_image_surface => $self->image_surfaces->[$index],
	);
}

method _build_identity_bounds() {
	my $surfaces = $self->image_surfaces;
	return [ map {
		{
			x => $surfaces->[$_]->get_height,
			y => $surfaces->[$_]->get_width,
			rotate => 0,
			pageno => $_ + 1,
			dims => {
				w => $surfaces->[$_]->get_width,
				h => $surfaces->[$_]->get_height,
			},
		}
	} 0..@$surfaces-1 ];
}

with qw(
	Renard::Incunabula::Document::Role::Pageable
	Renard::Incunabula::Document::Role::Renderable
	Renard::Incunabula::Document::Role::Boundable
);

1;
