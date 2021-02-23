#!/bin/sh

search=$(youtube-dl ytsearch:$1)
thumbnail=$($search --get-thumbnail)
