requires 'perl', '5.010001';

requires 'overload';
requires 'Carp';
requires 'Scalar::Util';
requires 'List::Util';

on 'test' => sub {
    requires 'Test2::V0', '0.000135';
    requires 'Module::Build::Tiny', '0.035';
}

