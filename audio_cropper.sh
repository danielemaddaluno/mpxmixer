#!/bin/bash

# Verifica se ci sono abbastanza argomenti
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 input_file output_file start_time end_time"
    exit 1
fi

input_file="$1"
output_file="$2"
start_time="$3"
end_time="$4"

# Utilizza FFmpeg per tagliare il file audio
ffmpeg -i "$input_file" -ss "$start_time" -to "$end_time" -c copy "$output_file"

echo "File audio tagliato con successo: $output_file"

# Usage
# ./crop_audio.sh input_audio.mp3 output_audio.mp3 00:00:10.500 00:00:30.250
