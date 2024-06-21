# yt2m4b
YouTube Playlist To Audiobook Converter

MacOS / Linux script to download YouTube playlist videos audio tracks and convert them into a an M4B (Apple format) audiobook. Ideal for video podcasts.

## Usage

```
./yt2m4b -p "https://music.youtube.com/playlist?list=PLx0sYbCqOb8TBPRdmBHs5Iftvv9TPboYG" -n 3 -o "/Users/nat/Music/Youtube/"
```

* -p playlist address
* -n number of recent videos to download
* -o output directory

Or set the parameters in the script itself if you want to run it regularly-
```
PLAYLIST_URL="https://music.youtube.com/playlist?list=PLx0sYbCqOb8TBPRdmBHs5Iftvv9TPboYG"
MAX_ITEMS=5
OUTPUT_DIR="/Users/me/Music/Youtube/"
```

## Requirements

The following tools are needed - FFMPEG, YT-DLP, JQ

```
# MacOs -
brew install ffmpeg yt-dlp jq
# Linux (Debian based) -
apt install ffmpef yt-dlp jq
```

## Audiobook players that support M4B

* iOS (Apple) apps - Books / Music / QuickTime
* Android apps - Smart Audiobook Player / Listen Audiobook Player
