#!/usr/bin/perl -w

use strict;
my $stable = 0;
my $wp = 0;

# Get AMSTracker from Amit Singh's site:
# http://www.osxbook.com/software/sms/amstracker/
# and put AMSTracker in same directory as smackleopard.command
#
open F,"./AMSTracker -s -u0.01 |";
while(<F>) {
    my @a = /(-?\d+)/g;
    print, next if @a != 3;

    # we get a signed short written as two unsigned bytes
    $a[0] += 256 if $a[0] < 0;
    my $x = $a[1]*256 + $a[0];

    if(abs($x) < 20) {
	$stable++;
    }

    # you can adjust sensitivity here
    # original file uses 30. 20 is better for me.
    if(abs($x) > 15 && $stable > 15) {
	$stable = 0;
	$wp = int(rand(45)) + 1;

	# check if it is LEFT or RIGHT tap
	# I use ^ArrowKeys for Leopard Spaces to switch.
	if ($x < 0) {
        	`osascript -e 'tell application \"Finder\" \n set desktop picture to POSIX file \"/Users/euc/Pictures/Wallpaper/$wp.jpg\"\n end tell'`
	} else {
        	`osascript -e 'tell application \"Finder\" \n set desktop picture to POSIX file \"/Users/euc/Pictures/Wallpaper/$wp.jpg\" \n end tell'`
	}
    }
}
