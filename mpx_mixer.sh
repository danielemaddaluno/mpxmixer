#!/bin/bash

# convert non mp4 videos to mp4
sh ./videos_to_mp4.sh

# Output folder naming convention
output_parent_folder="output"
output_folder="$output_parent_folder/output_$(date +'%Y_%m_%d_%H_%M_%S')"
mkdir -p "$output_folder"

# Get a list of video files and audio files
video_files=(video/*.mp4)
audio_files=(audio/*\ \(*\).mp3)  # Match files with pattern "(SS.mmm)" or "(SS)"

# Function to generate random number within a range
random_number() {
  local min=$1
  local max=$2
  echo $((min + RANDOM % (max - min + 1)))
}

# Process each video file
for video_file in "${video_files[@]}"; do
  # Select a random audio file
  random_audio_index=$(random_number 0 $((${#audio_files[@]} - 1)))
  audio_file="${audio_files[$random_audio_index]}"

  # Extract start time from audio file name
  start_time=$(echo "$audio_file" | sed -E 's/.*\(([0-9]+(\.[0-9]+)?)\).*/\1/')

  # Generate output file path
  output_file="$output_folder/$(basename "$video_file" .mp4)_$(basename "$audio_file" .mp3).mp4"

  # Use FFmpeg to add audio to the video starting from the specified time
  ffmpeg -i "$video_file" -i "$audio_file" -filter_complex "[1:a]adelay=$start_time[a];[0:a][a]amix=inputs=2:duration=first[aout]" -map 0:v -map "[aout]" -c:v copy -shortest "$output_file"

  echo "Audio added to $video_file from $audio_file starting at $start_time seconds and saved to $output_file"
done

echo "All videos processed successfully. Output files are in the folder: $output_folder"
