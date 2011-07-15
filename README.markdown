-*- Mode: auto-fill -*-

Tweaks for F-Secure Anti-Virus for Mac
======================================

F-Secure has an anti-virus product for Mac OS X, called F-Secure Mac
Protection in its "Technology Preview" incarnation and "F-Secure
Anti-Virus for Mac" in the retail version. The product has some nice
things going for it, but also some things that annoy me. I intend to
make it easy to get rid of the annoying parts while still keeping it a
bit safer to receive files from untrusted sources.

*NOTE:* This is not endorsed by F-Secure in any way. I am simply
documenting this because I want to repeat the steps I have taken, and
in the off chance someone else might find this useful, all the
better.


Disabling real-time scanning
----------------------------

First: https://gist.github.com/1021702

then:
	sudo launchctl unload -w /Library/LaunchDaemons/com.f-secure.clstate-periodic.plist

Disabling the UI
----------------

	sudo /usr/local/f-secure/bin/loginitem - "`find /Applications -name 'F-Secure Mac Protection.app' -depth 2`"
	killall fscuif

Install growlnotify
-------------------

Available as in the 'Extras' folder in the Growl (http://growl.info/)
installer dmg.

Set up scanning of downloaded files
-----------------------------------

Install a folder action Automator that runs the script
"folderaction.sh" available in the repo, and configure it for the
Downloads folder, with a code snippet like this:
	  /Users/rasmus/fsmactweaks/folderaction.sh "$@"

![Automator screenshot](https://github.com/pajp/fsmactweaks/raw/master/folderaction.png)
