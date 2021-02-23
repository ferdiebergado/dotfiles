#!/bin/sh

echo -e "notify(\"$1\", \"$2\", \"$3\")" | awesome-client
