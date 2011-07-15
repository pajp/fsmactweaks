#!/bin/bash

# script to automatically download and install Growl and growlnotify

err() {
    echo "$@"
    exit 1
}   

echo -n "Fetching URL of Growl..."

growlurl=`curl -s http://growl.info/|grep 'http.*Growl-.*[0-9].dmg'|sed -e 's/.*"\(http.*Growl-[0-9].*[0-9].dmg\)".*/\1/g'`

echo " found \"$growlurl\""

if ! [ "$growlurl" ] ; then
    err "Failed to find the URL of latest Growl dmg"
fi

set -e
dmg=`/usr/bin/mktemp -t growl.XXXXXX.dmg`
echo "Downloading Growl..."
curl $growlurl > $dmg
mountpoint=`hdiutil attach "$dmg" | tail -1 | awk 'BEGIN { FS = "\t" } { print $3 }'`
echo mount point: $mountpoint
if ! [ "$mountpoint" ] ; then
    err "failed to mount $dmg"
fi
echo "Scanning for malware (just to be sure)..."
fsav "$mountpoint"
echo "Installing Growl..."
sudo installer -package "${mountpoint}/Growl.pkg" -target /
echo "Installing growlnotify..."
sudo installer -package "${mountpoint}/Extras/growlnotify/growlnotify.pkg" -target /
hdiutil detach "$mountpoint"
echo "That went swell!"