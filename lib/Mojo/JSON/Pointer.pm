package Mojo::JSON::Pointer;

use utf8;

use Mojo::Base -strict;

use Mojo::Util 'url_unescape';

# "I've had it with this school, Skinner. Low test scores, class after
# class of ugly, ugly children…"
sub exists {
  my ($class, $json, $pointer) = @_;

  return undef unless $pointer =~ s/^\///;

  foreach my $t (split /\//, $pointer) {
    url_unescape $t;

    if (ref $json eq 'HASH' && exists $json->{$t}) {
      $json = $json->{$t};
    }
    elsif (ref $json eq 'ARRAY' && $t =~ /^[0-9]+$/ && @$json > $t) {
      $json = $json->[$t];
    }
    else {
      return 0;
    }
  }

  return 1;
}

sub get {
  my ($class, $json, $pointer) = @_;

  return undef unless $pointer =~ s/^\///;

  foreach my $t (split /\//, $pointer) {
    url_unescape $t;

    if (ref $json eq 'HASH' && exists $json->{$t}) {
      $json = $json->{$t};
    }
    elsif (ref $json eq 'ARRAY' && $t =~ /^[0-9]+$/ && @$json > $t) {
      $json = $json->[$t];
    }
    else {
      return undef;
    }
  }

  return $json;
}

1;
__END__

=head1 NAME

Mojo::JSON::Pointer - evaluate JSON Pointers

=head1 SYNOPSIS

  use Mojo::JSON::Pointer;

  my $json = $tx->res->json;
  if (Mojo::JSON::Pointer->exists($json, '/foo/bar/1')) {
    my $val = Mojo::JSON::Pointer->get($json, '/foo/bar/1');
  }

  # Convenient helpers in Mojo::Message and Test::Mojo

  my $val = $tx->res->json('/foo/bar/1');

  $t->json_is('/foo/bar/1', 'expected', 'right value!');
  $t->json_has('/foo/baz/2');

=head1 DESCRIPTION

L<Mojo::JSON::Pointer> evaluates JSON Pointer expressions against a
decoded JSON object.

See L<draft-pbryan-zyp-json-pointer-02|http://tools.ietf.org/html/draft-pbryan-zyp-json-pointer-02>
for details about the nascent JSON pointer syntax.

=head1 METHODS

=head2 C<exists>

  $has_foo = Mojo::JSON::Pointer->exists($res->json, '/foo');

Returns true if the JSON pointer identifies a value in the given JSON
structure.

=head2 C<get>

  $bar = Mojo::JSON::Pointer->get($res->json, '/foo/bar');

Returns the value identified by the JSON pointer in the given JSON
structure.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
