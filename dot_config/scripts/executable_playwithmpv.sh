#!/usr/bin/env bash

for filename in "$(ls)"; do
    extension=$([[ "$filename" = *.* ]] && echo ".${filename##*.}" || echo '')
    echo "$filename"
    [[ $extension == ".mp3" ]] && /usr/bin/mpv "$filename"
done
