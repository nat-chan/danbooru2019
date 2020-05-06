#!/bin/bash

# print out filenames of all SFW Danbooru images matching a particular tag.
# assumes being in root directory like '/media/gwern/Data2/danbooru2019'
TAG="monochrome"

cat metadata/all.json | fgrep -e '"name":"'"$TAG" | fgrep '"rating":"s"' \
    | jq -c '.id' | tr -d '"' > monochrome.dat

./difference.sh 512px.dat monochrome.dat > 512px-monochrome.dat
