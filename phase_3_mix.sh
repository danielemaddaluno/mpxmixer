#!/bin/bash

VIDEOS_IN=(video_tmp_2/*.mp4)
AUDIOS_IN=(audio/*\ \(*\).mp3)  # Match files with pattern "(SS.mmm)" or "(SS)"
VIDEOS_OUT="./output/output_$(date +'%Y_%m_%d_%H_%M_%S')"
mkdir -p "$VIDEOS_OUT"


# Function to generate random number within a range
random_number() {
  local min=$1
  local max=$2
  echo $((min + RANDOM % (max - min + 1)))
}

# Process each video file
for video_file in "${VIDEOS_IN[@]}"; do
  # Select a random audio file
  random_audio_index=$(random_number 0 $((${#AUDIOS_IN[@]} - 1)))
  audio_file="${AUDIOS_IN[$random_audio_index]}"

  # Extract start time from audio file name
  start_time=$(echo "$audio_file" | sed -E 's/.*\(([0-9]+(\.[0-9]+)?)\).*/\1/')

  # Generate output file path
  output_file="$VIDEOS_OUT/$(basename "$video_file" .mp4)_$(basename "$audio_file" .mp3).mp4"

  # Use FFmpeg to add audio to the video starting from the specified time
  ffmpeg -i "$video_file" -i "$audio_file" -filter_complex "[1:a]adelay=$start_time[a];[0:a][a]amix=inputs=2:duration=first[aout]" -map 0:v -map "[aout]" -c:v copy -shortest "$output_file"

  echo "Audio added to $video_file from $audio_file starting at $start_time seconds and saved to $output_file"
done

echo "All videos processed successfully. Output files are in the folder: '$VIDEOS_OUT'"
