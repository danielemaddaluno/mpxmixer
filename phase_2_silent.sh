#!/bin/bash

# This script processes video files located in the video_tmp_1 directory, strips their audio tracks,
# and saves the resulting videos in the video_tmp_2 directory.
# The script creates silent video files with the same content as the input but without audio.

VIDEOS_IN="./video_tmp_1/*.mp4"
VIDEOS_OUT="./video_tmp_2"

# Create the "./video_tmp" directory if it doesn't exist
mkdir -p $VIDEOS_OUT

# Loop through all video files in the "./video" directory
for video_file in $VIDEOS_IN; do
    # Extract the filename without extension
    filename=$(basename -- "$video_file")
    filename_noext="${filename%.*}"

    # Get the duration of the input video in seconds
    duration=$(ffprobe -i "$video_file" -show_entries format=duration -v quiet -of csv="p=0")

    # Create a silent audio track with the same duration as the input video
    ffmpeg -i "$video_file" -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -t "$duration" -c:v copy -c:a aac -strict experimental "$VIDEOS_OUT/${filename_noext}_no_sound.mp4"

    echo "Processed: ${filename}"
done

echo "All videos processed and saved in '$VIDEOS_OUT' directory."
