# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 2;

use HTML::Menu;
use Data::Dumper;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $m = HTML::Menu->new(file => 't/menu.dat');

is($m->bread('ba.html'),
'<span class="breadon"><a href="/b.html">B</a></span> &gt; <span class="breadoff">BA</span>');

is($m->menu('ba.html'),
'<a class="menuoff" href="/a.html">A</a>
<a class="menuon" href="/b.html">B</a>
<p class="submenuon">BA</p>
<a class="submenuoff" href="/b/b.html">BB</a>
');

