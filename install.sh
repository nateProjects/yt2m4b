#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "yt2m4b installer"
echo "================"
echo ""

# Detect OS and distro
OS=$(uname -s)
DISTRO=""

if [ "$OS" = "Darwin" ]; then
  echo "Detected: macOS"
elif [ "$OS" = "Linux" ]; then
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO="$ID"
  fi
  echo "Detected: Linux ($DISTRO)"
else
  echo "Unsupported OS: $OS" >&2
  exit 1
fi

echo ""
echo "Checking dependencies..."
echo ""

DEPS=(ffmpeg yt-dlp jq)
MISSING=()

for dep in "${DEPS[@]}"; do
  if command -v "$dep" &>/dev/null; then
    echo "  [ok]     $dep"
  else
    echo "  [missing] $dep"
    MISSING+=("$dep")
  fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
  echo ""
  echo "Installing: ${MISSING[*]}"
  echo ""

  if [ "$OS" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
      echo "Homebrew is required but not installed."
      echo "Install it from https://brew.sh then re-run this script." >&2
      exit 1
    fi
    brew install "${MISSING[@]}"

  elif [ "$OS" = "Linux" ]; then
    case "$DISTRO" in
      ubuntu|debian|raspbian|linuxmint|pop)
        sudo apt-get update -qq
        sudo apt-get install -y "${MISSING[@]}" || {
          echo ""
          echo "apt install failed for some packages."
          echo "yt-dlp may not be in your apt repos — try: pip3 install yt-dlp"
          exit 1
        }
        ;;
      fedora)
        sudo dnf install -y "${MISSING[@]}"
        ;;
      rhel|centos|rocky|almalinux)
        sudo yum install -y "${MISSING[@]}"
        ;;
      arch|manjaro|endeavouros|garuda)
        sudo pacman -Sy --noconfirm "${MISSING[@]}"
        ;;
      opensuse*|sles)
        sudo zypper install -y "${MISSING[@]}"
        ;;
      *)
        echo "Unknown Linux distro: '$DISTRO'"
        echo "Please install the following manually: ${MISSING[*]}"
        echo "  ffmpeg  — https://ffmpeg.org/download.html"
        echo "  yt-dlp  — pip3 install yt-dlp"
        echo "  jq      — https://stedolan.github.io/jq/download/"
        exit 1
        ;;
    esac
  fi

  echo ""
  echo "Dependencies installed."
fi

# Make the script executable
chmod +x "$SCRIPT_DIR/yt2m4b"
echo ""
echo "Made yt2m4b executable."

# Offer to install to PATH
INSTALL_PATH="/usr/local/bin"
echo ""
read -r -p "Install yt2m4b to $INSTALL_PATH so it runs from anywhere? [y/N] " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  sudo cp "$SCRIPT_DIR/yt2m4b" "$INSTALL_PATH/yt2m4b"
  echo "Installed to $INSTALL_PATH/yt2m4b"
else
  echo "Skipped. Run with: $SCRIPT_DIR/yt2m4b"
fi

echo ""
echo "Setup complete!"
