package HTML::Menu;

use 5.006;
use strict;
use warnings;

use Carp;
use Data::Tree;

require Exporter;

our @ISA = qw(Exporter Data::Tree);
our $VERSION = '0.01';


sub new {
  my $class = shift;

  my $self = $class->SUPER::new(@_, 
				id => 'name', 
				separator => '\s*:\s*');

  bless $self, $class;

  return $self;
}

sub bread {
  my $self = shift;

  my $name = shift;

  my $curr = $self->{all}{$name};

  my @bread = 
    (map { qq(<span class="breadon"><a href="$_->{url}">$_->{text}</a></span>) }
      reverse $self->ancestors($name));

  push @bread, qq(<span class="breadoff">$curr->{text}</span>);

  return join ' &gt; ', @bread if @bread > 1;
  return '';
}

sub menu {
  my $self = shift;

  my $name = shift;

  my $menu;

  for (@{$self->{order}}) {
    my $curr = $self->{all}{$_};
    next if $curr->{parent};

    $menu .= $self->expand($name, $curr);
  }

  return $menu;
}

sub expand {
  my $self = shift;

  my ($name, $curr) = @_;
  my $pre = defined $_[2] ? $_[2] : '';

  return if $self->level($curr->{name}) > 1;

  my $menu = '';

  if ($name eq $curr->{name}) {
    $menu .= qq(<p class="${pre}menuon">$curr->{text}</p>\n);
    for my $c (@{$curr->{children}}) {
      $menu .= $self->expand($name, $c, "sub$pre");
    }
  } elsif ($self->is_ancestor($curr->{name}, $name)) {
    $menu .= qq(<a class="${pre}menuon" href="$curr->{url}">$curr->{text}</a>\n);
    for my $c (@{$curr->{children}}) {
      $menu .= $self->expand($name, $c, "sub$pre");
    }
  } else {
    $menu .= qq(<a class="${pre}menuoff" href="$curr->{url}">$curr->{text}</a>\n);
  }

  return $menu;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

HTML::Menu - Perl extension for blah blah blah

=head1 SYNOPSIS

  use HTML::Menu;
  blah blah blah

=head1 ABSTRACT

  This should be the abstract for HTML::Menu.
  The abstract is used when making PPD (Perl Package Description) files.
  If you don't want an ABSTRACT you should also edit Makefile.PL to
  remove the ABSTRACT_FROM option.

=head1 DESCRIPTION

Stub documentation for HTML::Menu, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Dave Cross, E<lt>dave@mag-sol.demon.co.ukE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2002 by Dave Cross

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
