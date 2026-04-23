# yt2m4b
YouTube Playlist To Audiobook Converter

MacOS / Linux script to download YouTube playlist videos audio tracks and convert them into a an M4B (Apple format) audiobook, preserving episodes. Ideal for video podcasts.

## Install

```
./install.sh
```

The install script detects your OS (macOS or Linux) and installs any missing dependencies (`ffmpeg`, `yt-dlp`, `jq`) using the appropriate package manager. It will also offer to copy the script to `/usr/local/bin` so it runs from anywhere.

## Usage

```
./yt2m4b -p "https://youtube.com/playlist?list=..." -n 3 -o "/Users/me/Music/Youtube/"
```

| Flag | Description | Default |
|------|-------------|---------|
| `-p` | Playlist URL | (example playlist) |
| `-n` | Number of recent videos to download | `5` |
| `-o` | Output directory | `/Users/me/Music/Youtube/` |
| `-t` | Audiobook title | `Youtube Playlist` |
| `-a` | Artist / author name | `Various` |
| `-c` | Path to cover image (JPEG or PNG) | none |

### Example with all options

```
./yt2m4b \
  -p "https://youtube.com/playlist?list=PLxxx" \
  -n 10 \
  -o "/Users/me/Music/Podcasts/" \
  -t "My Podcast" \
  -a "Podcast Author" \
  -c "/Users/me/Pictures/cover.jpg"
```

Or set the parameters in the script itself if you want to run it on a schedule:
```bash
PLAYLIST_URL="https://music.youtube.com/playlist?list=PLx0sYbCqOb8TBPRdmBHs5Iftvv9TPboYG"
MAX_ITEMS=5
OUTPUT_DIR="/Users/me/Music/Youtube/"
TITLE="My Playlist"
AUTHOR="Various"
COVER_IMAGE="/path/to/cover.jpg"
```

## Requirements

The following tools are needed: `ffmpeg`, `yt-dlp`, `jq`

Use `./install.sh` to install them automatically, or manually:

```bash
# macOS
brew install ffmpeg yt-dlp jq

# Linux (Debian/Ubuntu)
apt install ffmpeg yt-dlp jq

# Both — make the script executable
chmod +x yt2m4b
```

## Audiobook players that support M4B

* iOS (Apple) apps — Books / Music / QuickTime
* Android apps — Smart Audiobook Player / Listen Audiobook Player
