#!/bin/bash

# Create the "./video_tmp" directory if it doesn't exist
mkdir -p ./video_tmp

# Loop through all video files in the "./video" directory
for video_file in ./video/*.mp4; do
    # Extract the filename without extension
    filename=$(basename -- "$video_file")
    filename_noext="${filename%.*}"

    # Get the duration of the input video in seconds
    duration=$(ffprobe -i "$video_file" -show_entries format=duration -v quiet -of csv="p=0")

    # Create a silent audio track with the same duration as the input video
    ffmpeg -i "$video_file" -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -t "$duration" -c:v copy -c:a aac -strict experimental "./video_tmp/${filename_noext}_no_sound.mp4"

    echo "Processed: ${filename}"
done

echo "All videos processed and saved in ./video_tmp directory."
