# DashcamMovie2GPSImages

Simple and stupid tool that converts a given RAW dashcam movie (.mp4) to GPS-tagged JPG frames every second.

You can use those images to upload it to your self-hosted [GeoVisio aka. Panoramax](https://gitlab.com/geovisio/api/-/blob/develop/docs/14_Running_Docker.md) instance or one of the public servers.

Should work with many Dashcams, if yours is not working try using a newer version of exiftool!

## Usage

**Download `exiftool`:**  
`$ wget https://exiftool.org/Image-ExifTool-12.84.tar.gz && tar -xzf Image-ExifTool-12.84.tar.gz && mv Image-ExifTool-12.84 exif && rm Image-ExifTool-12.84.tar.gz`

**Execute `tool.sh`:**  
`$ bash tool.sh <dashcam-movie>.MP4`

**Results:**  
Have a look at the created folder `frames_<dashcam-movie>`

## Dependencies

- Linux
- bash
- ffmpeg (in PATH)
- exiftool (alongside with tool.sh)
- perl

## Known Issue

**Timezones**  
Have a look on Line 20: `date -d "$i -0 hour" +'%Y%m%d%H%M.%S'`, you can modify the `-0 hour` to your needs.

You need to adjust here in one ore the other direction if the logs says all the time something like `Time is too far [beyond|before] track`

**too much frames**  
ffmpeg sometimes generates one frame too much, this frame cannot be tagged.

## Tested with

- [Image-ExifTool-12.84](https://exiftool.org/index.html)
- Azdome GS63H RAW-.MP4-file (directly from SD Card)
- ffmpeg 4.4.2
- Linux 6.8.0
