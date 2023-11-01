@echo off
setlocal enabledelayedexpansion

REM Output folder naming convention
set "output_parent_folder=output"
set "output_folder=%output_parent_folder%\output_%date:~4,4%_%date:~7,2%_%date:~10,2%_%time:~0,2%_%time:~3,2%_%time:~6,2%"
mkdir "!output_folder!"

REM Get a list of video files and audio files
set "video_folder=video"
set "audio_folder=audio"
for %%v in (%video_folder%\*.mp4) do (
    set /a "random_audio_index=!random! %% 6"
    for /f "delims=" %%a in ('dir /b /a-d "%audio_folder%\*.mp3" ^| more +!random_audio_index!') do (
        set "audio_file=%%a"
        for /f "tokens=2 delims=() " %%t in ("!audio_file!") do (
            set "start_time=%%t"
        )

        REM Generate output file path
        set "output_file=!output_folder!\%%~nv_%%~na.mp4"

        REM Use FFmpeg to add audio to the video starting from the specified time
        ffmpeg -i "%%v" -i "!audio_folder!\!audio_file!" -filter_complex "[1:a]adelay=!start_time![a];[0:a][a]amix=inputs=2:duration=first[aout]" -map 0:v -map "[aout]" -c:v copy -shortest "!output_file!"

        echo Audio added to "%%v" from "!audio_file!" starting at !start_time! seconds and saved to "!output_file!"
    )
)

echo All videos processed successfully. Output files are in the folder: !output_folder!
