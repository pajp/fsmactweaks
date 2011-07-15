-*- Mode: auto-fill -*-

Tweaks for F-Secure Anti-Virus for Mac
======================================

F-Secure has an anti-virus product for Mac OS X, called *F-Secure Mac
Protection* in its "Technology Preview" incarnation and *F-Secure
Anti-Virus for Mac* in the retail version. Detailed in this file and
repository are tweaks I have made to make it suit my needs better.

See:
http://www.f-secure.com/en/web/home_global/protection/anti-virus-for-mac/overview
http://www.f-secure.com/en_EMEA-Labs/beta-programs/home-users-beta/fsmac/

*NOTE:* This is not endorsed by F-Secure in any way. I am simply
documenting this because I want to repeat the steps I have taken, and
in the off chance someone else might find this useful, all the
better. If things break, you're on your own.

TODO:
-----
 * Product upgrade notifications (signature updates should work, but
   you will not receive notifications about full product upgrades
   until the UI is launched).
 * Database update notifications (not necessary, but some people find
   it oddly reassuring).


Disabling real-time scanning
----------------------------

First: https://gist.github.com/1021702

then (optional, but reduces syslog noise):
	sudo launchctl unload -w /Library/LaunchDaemons/com.f-secure.clstate-periodic.plist

Disabling the UI
----------------

	sudo /usr/local/f-secure/bin/loginitem - "`find /Applications -name 'F-Secure Mac Protection.app' -depth 2`"
	killall fscuif

The user-interface can still be launched manually from the
Applications folder, for example to scan files or manage your
subscription.

Install Growl
-------------

We'll use it for displaying important information. Find it here:
http://growl.info/


To speed things up, you can run the included script
`install-growl.sh`, which may or may not be able to automatically
download and install the latest version of Growl and growlnotify.

Install growlnotify
-------------------

(Naturally, you can skip this if you have successfully run
`install-growl.sh`).

Available as in the 'Extras' folder in the Growl (http://growl.info/)
installer dmg. This will be used in the next section for setting up
automatic scanning of downloaded files.

Set up scanning of downloaded files
-----------------------------------

Start Automator and create a new Folder Action. Select your
"Downloads" folder as the target by "Folder Action receives files and
folders added to". Drag the "Run Shell Script" action into the
Automator flow, and add a code snippet like this (adjust path to where
you have checked out fsmactweaks):

	  /Users/rasmus/fsmactweaks/folderaction.sh "$@"

![Automator screenshot](https://github.com/pajp/fsmactweaks/raw/master/folderaction.png)

Create similar Folder Actions for all folders where regularly receive
files, for example through BitTorrent. If you're using Transmission,
it may make sense to set the "Keep incomplete files in..." preference
to a temporary directory and then add the Folder Action to the folder
where the completed downloads are moved.

Set up license reminder
-----------------------

If your license expires, you won't get any updates from F-Secure,
which would kind of defeat the point of having an anti-virus. Without
the F-Secure UI running, you won't notice if that happens. That's
where the `checklicense.sh` script comes in handy, and its launchd(8)
plist file that will run it once per day to let you know if you need
to take action. To set up, modify the plist file so that the path to
`checklicense.sh` matches your system, then run.

	  launchctl load /Users/rasmus/fsmactweaks/nu.dll.fsmactweaks.licensecheck.plist

(also modify the path to wherever the plist file is located on your
system, of course)
