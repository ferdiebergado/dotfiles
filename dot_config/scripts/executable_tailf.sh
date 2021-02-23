#!/bin/sh

tail -f $1 | while read; do
    echo "[ $(date +%D-%T) ] $REPLY"
done
