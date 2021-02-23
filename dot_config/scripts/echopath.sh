#!/bin/sh

IFS=:

for p in $PATH; do
    fd -c never . "$p"
done
