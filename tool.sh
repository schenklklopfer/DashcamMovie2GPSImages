#!/bin/bash

INPUT=$1
FILE=$(echo $INPUT | awk -F '.' '{print $1}')
MOV="$FILE.MP4"
GPS="$FILE.gps"
GPX="$FILE.gpx"
DEST="frames_$FILE"
mkdir -p data

function generate_frames() {
    ffmpeg -i $MOV -vf fps=1 -qscale:v 3 $DEST/frame_%04d.jpg
}

function generate_gpx() {
    ./exif/exiftool -p exif/fmt_files/gpx.fmt -ee $MOV > data/$GPX
}

function generate_timestamps() {
    for i in $(grep time data/$GPX | tr -d ' \<\/time\>'); do
        date -d "$i -0 hour" +'%Y%m%d%H%M.%S'
    done
}

function write_timestamps() {
    ls $DEST/ > data/$FILE.list

    generate_timestamps > data/$FILE.stamps

    while IFS= read -r line1 && IFS= read -r line2 <&3; do
    echo "LIST: $line1, STAMP: $line2"
        touch -a -m -t $line2 $DEST/$line1
    done < data/$FILE.list 3< data/$FILE.stamps
}

function write_geotag() {
    ./exif/exiftool -geotag data/$GPX '-geotime<FileModifyDate' $DEST/
}

# exiftool debugger: -v2
mkdir -p $DEST
generate_frames
generate_gpx
write_timestamps
write_geotag
rm $DEST/*_original