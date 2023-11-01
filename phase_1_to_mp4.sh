#!/bin/bash

# This Bash script is designed to convert non-MP4 video files to the MP4 format using FFmpeg,
# a powerful multimedia processing tool. The script processes files located in the "videos" directory,
# creating a new directory named "videos_tmp" to store the converted MP4 files.

# Create the "./video_tmp" directory if it doesn't exist
VIDEOS_IN="./video/*"
VIDEOS_OUT="./video_tmp_1"
mkdir -p $VIDEOS_OUT

# Convert non-MP4 videos to MP4 and place them in the "video" folder
for video_file in $VIDEOS_IN; do
  if [[ "$video_file" != *.mp4 ]]; then
    # Extract file name and extension
    filename=$(basename "$video_file")
    filename_noext="${filename%.*}"
    output_file="$VIDEOS_OUT/${filename_noext}.mp4"

    # Use FFmpeg to convert to MP4 (force overwrite)
    ffmpeg -i "$video_file" -c:v libx264 -preset medium -crf 23 -c:a aac -strict experimental -y "$output_file"

    echo "Converted $video_file to $output_file"
  else
    cp "$video_file" $VIDEOS_OUT
  fi
done

echo "Conversion complete. MP4 files are in the '$VIDEOS_OUT' folder."
