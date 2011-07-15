#!/bin/bash

gn() {
    growlnotify -n "fsmactweaks" -d "nu.dll.fsmactweaks" -a "F-Secure Mac Protection" "$@"
}

tf=`mktemp -t`
fsav --version > $tf
rc=$?
iseval=false
invalid=false
grep -q ^EVALUATION $tf && iseval=true
grep -q ^INVALID $tf && invalid=true

if $iseval; then
    echo "You are running an unregistered version and may not receive updates." | gn -s Warning
fi

if $invalid; then
    if gn -w -s -m "Your keycode is invalid or has expired and you will not receive updates. Click here to start the GUI to enter a new keycode." Warning ; then
	open -a "F-Secure Mac Protection"
	sleep 5
	open -a "F-Secure Mac Protection"
    fi    
fi

