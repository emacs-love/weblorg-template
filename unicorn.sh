#!/bin/bash

daemon() {
    chsum1=""

    while [[ true ]]
    do
        chsum2=`find src/ -type f -exec md5sum {} \;`
        if [[ $chsum1 != $chsum2 ]] ; then
            if [ -n "$chsum1" ]; then
                emacs --script publish.el
            fi
            chsum1=$chsum2
        fi
        sleep 2
    done
}

if [[ -z "$1" ]]; then
    daemon
else
    ENV='prod' emacs --script publish.el
fi

