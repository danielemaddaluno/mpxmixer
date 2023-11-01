#!/bin/bash

# Convert non-MP4 videos to MP4 and place them in the "video" folder
for video_file in video/*; do
  if [[ "$video_file" != *.mp4 ]]; then
    # Extract file name and extension
    filename=$(basename "$video_file")
    filename_noext="${filename%.*}"
    output_file="video/${filename_noext}.mp4"

    # Use FFmpeg to convert to MP4 (force overwrite)
    ffmpeg -i "$video_file" -c:v libx264 -preset medium -crf 23 -c:a aac -strict experimental -y "$output_file"

    echo "Converted $video_file to $output_file"
  fi
done

echo "Conversion complete. MP4 files are in the 'video' folder."
