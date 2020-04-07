#!/bin/bash
if [[ -n $2 && $2 == "-r" ]]; then
    find . -name "*$1*"
else
    find . -maxdepth 1 -name "*$1*"
fi
