use Renard::Curie::Setup;
package Renard::Curie::Model::Document::Role::Pageable;
# ABSTRACT: Role for documents that have numbered pages

use Moo::Role;
use Renard::Curie::Types qw(PageNumber);

=attr first_page_number

A C<PageNumber> containing the first page number of the document.
This is always C<1>.

=cut
has first_page_number => (
	is => 'ro',
	isa => PageNumber,
	default => 1,
);


=attr last_page_number

A C<PageNumber> containing the last page number of the document.

=cut
has last_page_number => (
	is => 'lazy', # _build_last_page_number
	isa => PageNumber,
);


1;
