#!/usr/bin/perl -w

use strict;

use lib './t';

use Params::Validate qw(validate);

use Test::More;
plan tests => $] == 5.006 ? 2 : 3;

eval { foo() };
like( $@, /parameter 'foo'/ );

{
    local $Params::Validate::NO_VALIDATION = 1;

    eval { foo() };
    is( $@, '' );
}

unless ( $] == 5.006 )
{
    eval { foo() };
    like( $@, /parameter 'foo'/ );
}

sub foo
{
    validate( @_, { foo => 1 } );
}
