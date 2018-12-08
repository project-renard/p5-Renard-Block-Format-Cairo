use Renard::Incunabula::Common::Setup;
package Renard::Block::Format::Cairo::Types;
# ABSTRACT: Type library

use Type::Library 0.008 -base,
	-declare => [qw(
		RenderableDocumentModel
		RenderablePageModel
	)];
use Type::Utils -all;

=type RenderableDocumentModel

A type for any reference that does
L<Renard::Incunabula::Document::Role::Renderable>.

=cut
role_type "RenderableDocumentModel",
	{ role => "Renard::Incunabula::Document::Role::Renderable" };

=type RenderablePageModel

A type for any reference that does
L<Renard::Incunabula::Page::Role::CairoRenderable>.

=cut
role_type "RenderablePageModel",
	{ role => "Renard::Incunabula::Page::Role::CairoRenderable" };

1;
