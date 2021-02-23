#!/usr/bin/bash

# Define the clock
Clock() {
    DATETIME=$(date "+%a %b %d, %R")
    echo -n "$DATETIME"
}


# Print the status bar
while true; do
    echo "$(Clock)"
    sleep 60
done
