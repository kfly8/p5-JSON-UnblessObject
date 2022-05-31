[![Actions Status](https://github.com/kfly8/p5-Object-UnblessWithJSONSpec/actions/workflows/test.yml/badge.svg)](https://github.com/kfly8/p5-Object-UnblessWithJSONSpec/actions) [![Coverage Status](http://codecov.io/github/kfly8/p5-Object-UnblessWithJSONSpec/coverage.svg?branch=main)](https://codecov.io/github/kfly8/p5-Object-UnblessWithJSONSpec?branch=main) [![MetaCPAN Release](https://badge.fury.io/pl/Object-UnblessWithJSONSpec.svg)](https://metacpan.org/release/Object-UnblessWithJSONSpec)
# NAME

Object::UnblessWithJSONSpec - unbless object using JSON spec like Cpanel::JSON::XS::Type

# SYNOPSIS

```perl
use Object::UnblessWithJSONSpec qw(unbless_with_json_spec);

use Cpanel::JSON::XS::Type;

{
    package SomeEntity;
    sub new {
        my ($class, %args) = @_;
        return bless \%args, $class
    }
    sub a { shift->{a} }
    sub b { shift->{b} }
}

my $entity = SomeEntity->new(a => 123, b => 'HELLO');

unbless_with_json_spec($entity, { a => JSON_TYPE_INT });
# => { a => 123 }

unbless_with_json_spec($entity, { b => JSON_TYPE_STRING });
# => { b => 'HELLO' }

unbless_with_json_spec($entity, { a => JSON_TYPE_INT, b => JSON_TYPE_STRING });
# => { a => 123, b => 'HELLO' }
```

# DESCRIPTION

Object::UnblessWithJSONSpec is designed to assist with JSON encode.
For example, an blessed object can be encoded using JSON spec:

```perl
use Cpanel::JSON::XS ();
use Scalar::Util qw(blessed);

my $json = Cpanel::JSON::XS->new->canonical;
sub encode_json {
    my ($data, $spec) = @_;

    $data = unbless_with_json_spec($data, $spec) if blessed $data;
    $json->encode($data, $spec)
}

encode_json($entity, { a => JSON_TYPE_INT });
# => {"a":123}

encode_json($entity, { b => JSON_TYPE_STRING });
# => {"b":"HELLO"}

encode_json($entity, { a => JSON_TYPE_INT, b => JSON_TYPE_STRING }),
# => {"a":123,"b":"HELLO"}
```

# LICENSE

Copyright (C) kfly8.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

kfly8 <kfly@cpan.org>
