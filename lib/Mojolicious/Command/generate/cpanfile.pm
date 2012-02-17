package Mojolicious::Command::generate::cpanfile;
use Mojo::Base 'Mojo::Command';

has description => qq/Generate cpanfile for dependencies".\n/;
has usage       => "usage: $0 generate cpanfile\n";

# " What is the mind?
#   Is it just a system of impulses?
#   Or is it something tangible?
#   Relax.  What is mind?  No matter.  What is matter?  Never mind! "

sub run {
  my $self  = shift;
  my $class = $ENV{MOJO_APP};
  $class = 'MyApp' if !$class || ref $class;
  my $path = $self->class_to_path($class);
  my $name = $self->class_to_file($class);
  $self->render_to_rel_file('cpanfile', 'cpanfile', $class, $path, $name);
}

1;
__DATA__

@@ cpanfile
requires Mojolicious => '2.0';

__END__
=head1 NAME

Mojolicious::Command::generate::cpanfile - cpanfile generator command

=head1 SYNOPSIS

  use Mojolicious::Command::generate::cpanfile;

  my $cpanfile = Mojolicious::Command::generate::cpanfile->new;
  $cpanfile->run(@ARGV);

=head1 DESCRIPTION

L<Mojolicious::Command::generate::cpanfile> is a cpanfile generator.

=head1 ATTRIBUTES

L<Mojolicious::Command::generate::cpanfile> inherits all attributes from
L<Mojo::Command> and implements the following new ones.

=head2 C<description>

  my $description = $makefile->description;
  $makefile       = $makefile->description('Foo!');

Short description of this command, used for the command list.

=head2 C<usage>

  my $usage = $cpanfile->usage;
  $makefile = $cpanfile->usage('Foo!');

Usage information for this command, used for the help screen.

=head1 METHODS

L<Mojolicious::Command::generate::cpanfile> inherits all methods from
L<Mojo::Command> and implements the following new ones.

=head2 C<run>

  $cpanfile->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
