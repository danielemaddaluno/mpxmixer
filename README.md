# Mpx Mixer: mp3-mp4 mixer utilities

## Prerequisite
You have to install `ffmpeg` on your system and add it to the `PATH`.

### On Windows
1. Install `chocolatey` following this [guide](https://chocolatey.org/install).
2. Install `ffmpeg` using the following command:
     ```bash
    choco install ffmpeg
    ```

### On MacOS
1. Install `brew` following this [guide](https://brew.sh/).
   Normally executing:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. Install `ffmpeg` using the following command:
     ```bash
    brew install ffmpeg
    ```



## Setup
Download the zip clicking this [link](https://github.com/ailpix/mpxmixer/archive/refs/heads/main.zip).
<br>
Unzip it somewhere.
<br>
Then follow these steps:
1. Put your mp4 video under the `video` folder.
2. Put your mp3 audio under the `audio` folder.
3. Rename the mp3 files using this naming convention:
   - `{filename} (SS.mmm).mp3`
   - `SS.mmm` stands for `seconds.microseconds` from where the audio have to be sampled.
   - If you want the same audio to be used with different starting sample time simply copy and paste 
     the file and change the final name of the file (the final part `SS.mmm`).



So the directory structure should be something like the following structure:
```
.
├── audio
│   ├── filename1 (0).mp3
│   ├── filename2 (11.000).mp3
│   └── filename3 (10.500).mp3
├── video
│   ├── video1.mp4
│   ├── video2.mp4
│   ├── video3.mp4
│   └── video4.mp4
├── README.md
├── audio_cropper.sh
├── mpx_mixer.bat
└── mpx_mixer.sh
```

## Run
./
### On Windows
Click on the bat file or execute the following command:
```bash
mpx_mixer.bat
```


### On MacOS
Execute the following command:
```bash
./mpx_mixer.sh
```

## Output
Here's a brief explanation of what the provided script does:

1. Output Folder Naming:
   - The script creates an output folder with a name following the pattern: output_yyyy_MM_dd_HH_mm_ss, where yyyy represents the current year, MM represents the current month, dd represents the current day, HH represents the current hour, mm represents the current minute, and ss represents the current second. The folder is created inside the output directory.

2. Audio and Video Files:
   - The script processes each video file in the video folder.
   - It selects a random audio file from the audio folder.
   - The audio file selection considers the pattern in the format (SS.mmm) where SS represents seconds and mmm represents microseconds.

3. Adding Audio to Video:
   - The selected audio file is added to the corresponding video file.
   - The audio is inserted into the video starting from the specified time (SS.mmm), as per the naming convention of the audio file.
   - The output is saved in the generated output folder.

4. Output Naming:
   - The output files are named based on the original video file name and the selected audio file name, indicating that audio has been added.

5. Logging:
   - The script logs the process, indicating which audio file was added to which video file and at what specific time.
   - After processing all video files, it displays a completion message with the location of the output files.

In summary, the script creates a set of modified videos where random audio clips are added to the original videos, starting from specific seconds and microseconds as specified in the audio file names. The output files are organized in the output directory, within timestamped subdirectories, making it easier to track and manage the processed videos.