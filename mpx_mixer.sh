#!/bin/bash

./phase_1_to_mp4.sh
./phase_2_silent.sh
./phase_3_mix.sh

rm -r video_tmp_*
