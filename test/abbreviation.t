#! /usr/bin/env perl
################################################################################
##
## Copyright 2006 - 2014, Paul Beckingham, Federico Hernandez.
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be included
## in all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
## OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
## THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.
##
## http://www.opensource.org/licenses/mit-license.php
##
################################################################################

use strict;
use warnings;
use Test::More tests => 19;

# Ensure environment has no influence.
delete $ENV{'TASKDATA'};
delete $ENV{'TASKRC'};

use File::Basename;
my $ut = basename ($0);
my $rc = $ut . '.rc';

# Create the rc file.
if (open my $fh, '>', $rc)
{
  print $fh "data.location=.\n",
            "abbreviation.minimum=1\n";
  close $fh;
}

# Test the priority attribute abbrevations.
qx{../src/task rc:$rc add priority:H with 2>&1};
qx{../src/task rc:$rc add without 2>&1};

my $output = qx{../src/task rc:$rc list priority:H 2>&1};
like   ($output, qr/\bwith\b/,    "$ut: priority:H with");
unlike ($output, qr/\bwithout\b/, "$ut: priority:H without");

$output = qx{../src/task rc:$rc list priorit:H 2>&1};
like   ($output, qr/\bwith\b/,    "$ut: priorit:H with");
unlike ($output, qr/\bwithout\b/, "$ut: priorit:H without");

$output = qx{../src/task rc:$rc list priori:H 2>&1};
like   ($output, qr/\bwith\b/,    "$ut: priori:H with");
unlike ($output, qr/\bwithout\b/, "$ut: priori:H without");

$output = qx{../src/task rc:$rc list prior:H 2>&1};
like   ($output, qr/\bwith\b/,    "$ut: prior:H with");
unlike ($output, qr/\bwithout\b/, "$ut: prior:H without");

$output = qx{../src/task rc:$rc list prio:H 2>&1};
like   ($output, qr/\bwith\b/,    "$ut: prio:H with");
unlike ($output, qr/\bwithout\b/, "$ut: prio:H without");

$output = qx{../src/task rc:$rc list pri:H 2>&1};
like   ($output, qr/\bwith\b/,    "$ut: pri:H with");
unlike ($output, qr/\bwithout\b/, "$ut: pri:H without");

# Test the version command abbreviations.
$output = qx{../src/task rc:$rc version 2>&1};
like ($output, qr/MIT\s+license/, "$ut: version");

$output = qx{../src/task rc:$rc versio 2>&1};
like ($output, qr/MIT\s+license/, "$ut: versio");

$output = qx{../src/task rc:$rc versi 2>&1};
like ($output, qr/MIT\s+license/, "$ut: versi");

$output = qx{../src/task rc:$rc vers 2>&1};
like ($output, qr/MIT\s+license/, "$ut: vers");

$output = qx{../src/task rc:$rc ver 2>&1};
like ($output, qr/MIT\s+license/, "$ut: ver");

$output = qx{../src/task rc:$rc ve 2>&1};
like ($output, qr/MIT\s+license/, "$ut: ve");

$output = qx{../src/task rc:$rc v 2>&1};
like ($output, qr/MIT\s+license/, "$ut: v");

# Cleanup.
unlink qw(pending.data completed.data undo.data backlog.data), $rc;
exit 0;

