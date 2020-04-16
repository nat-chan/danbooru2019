#!/bin/bash
center512px() {
    ID=$( basename "$@"  | cut -d '.' -f 1)
    EXT=$( basename "$@" | cut -d '.' -f 2)
    BUCKET=$(printf "%04d" $(( $ID % 1000 )) )
    size="512x512"
    DST=center512px
    if [[ ! -a ./$DST/$BUCKET/$ID.jpg ]]; then
        if [ $EXT = "jpg" -o $EXT = "jpeg" ]; then
            convert \
                -define jpeg:size=$size \
                -resize "$size^" \
                -gravity center \
                -extent $size \
                "$@" ./$DST/$BUCKET/$ID.jpg
        elif [ $EXT = "gif" ]; then
            convert \
                -resize "$size^" \
                -gravity center \
                -extent $size \
                "$@[0]" ./$DST/$BUCKET/$ID.jpg
        else
            convert \
                -resize "$size^" \
                -gravity center \
                -extent $size \
                "$@" ./$DST/$BUCKET/$ID.jpg
        fi
    fi
}
export -f center512px

find_images() {
    find original/ -type f -iname "*.jp*g" -or -iname "*.png" -or -iname "*.gif" -or -iname "*.bmp"
}
export -f find_images

#find_images | tail -n +1800000 | parallel -j6 --progress --no-notice --joblog=../resize_log.txt rescale512px
# delete any exploded JPG forms of animated GIFs; they're no good for anything:
#find 512px/ -type f -name "*-[[:digit:]]*.jpg" -delete

for i in {0000..0999}; do
    echo -e "\033[32m$i\033[m"
    find original/$i -type f -iname "*.jp*g" -or -iname "*.png" -or -iname "*.gif" -or -iname "*.bmp" |\
        parallel -j22 --progress --no-notice --joblog=./resize_log.txt center512px
done

# 1
# 2322979
# avi
# bmp
# gif
# html
# jpeg
# jpg
# mp3
# mp4
# mpg
# pdf
# png
# rar
# swf
# webm
# wmv
# zip
