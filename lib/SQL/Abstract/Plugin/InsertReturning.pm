package SQL::Abstract::Plugin::InsertReturning;
our $VERSION = '0.01';


# ABSTRACT: Augment SQL::Abstract->insert with support for returning data

use strict;
use warnings;

use Sub::Exporter -setup => {
    into => 'SQL::Abstract',
    exports => [qw( insert_returning )],
    groups => {
        default => [qw( insert_returning )]
    }
};

=head1 SYNOPSIS

    use SQL::Abstract;
    use SQL::Abstract::Plugin::InsertReturning;

    my $sql = SQL::Abstract->new;
    my ($query, @bind) = $sql->insert_returning('pets', {
        name => 'Fluffy Munchkins', type => 'Kitty' 
    }, [qw( name type )]);

    print $sql;
    # INSERT INTO pets ( name, type ) VALUES ( ?, ? ) RETURNING name, type;

=head1 DESCRIPTION

Some databases have support for returning data after an insert query, which can
help gain performance when doing common operations such as inserting and then
returning the new objects ID.

This plugin exports the C<insert_returning> method into the L<SQL::Abstract>
namespace, allowing you to call it much like any other method.

=head1 METHODS

=head2 insert_returning($table, \@values || \%fieldvals, \@returning)

Forms an SQL query with both an C<INSERT> part and a C<RETURNING> part. The
C<INSERT> part is generated by L<SQL::Abstract>'s C<insert> method, and both the
C<$table> and C<$fieldvals> values are passed directly to it. The returning SQL
is then altered to have a returning statement.

C<\@returning> is an array reference of column names that should be
returned.

This method will return an array of the SQL generated, and then all bind
parameters. 

=cut

sub insert_returning {
    my ($self, $table, $fieldvals, $returning) = @_;
    my ($sql, @bind) = $self->insert($table, $fieldvals);
    if ($returning) {
        my $cols = (ref $returning eq 'ARRAY') ? join ', ', map { $self->_quote($_) } @$returning
                                               : $returning;
        $sql .= $self->_sqlcase('returning') . " $cols";
    }
    return wantarray ? ($sql, @bind) : $sql;
}

1;


