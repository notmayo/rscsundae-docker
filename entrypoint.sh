#!/bin/sh
set -e

REPO_URL="https://git.sr.ht/~stormy/rscsundae"
CLONE_DIR="/opt/rscsundae"
DATA_DIR="/data"
CONFIG_FLAG="$CLONE_DIR/.configured"

# Check for interactive mode
if [ ! -t 0 ]; then
  echo "⚠️  WARNING: This container is not running in interactive mode."
  echo "💡 Tip: Run with '-it' to avoid issues. Example:"
  echo "    docker run -it -v /your/local/path/data:/data -p 43594:43594 rscsundae"
  exit 1
fi

# Ensure /data is mounted
if ! mountpoint -q "$DATA_DIR"; then
  echo "⚠️  /data is not a mounted directory!"
  echo "💡 Tip: Run with: docker run -it -v /your/local/path/data:/data -p 43594:43594 rscsundae"
  mkdir -p "$DATA_DIR"
fi

# Clone or update RSCSundae
if [ ! -d "$CLONE_DIR/.git" ]; then
  echo "📥 Cloning RSCSundae..."
  git clone --recurse-submodules "$REPO_URL" "$CLONE_DIR"
else
  echo "📦 Updating RSCSundae..."
  git -C "$CLONE_DIR" pull
  git -C "$CLONE_DIR" submodule update --init --recursive
fi

cd "$CLONE_DIR"

# Configure once
if [ ! -f "$CONFIG_FLAG" ]; then
  echo "⚙️  Running ./configure..."
  ./configure
  touch "$CONFIG_FLAG"
fi

# Build the server
echo "🛠️  Building in /src..."
cd src
make -j2

# Seed default data on first run
if [ ! -f "$DATA_DIR/settings.ini" ]; then
  echo "📋 Copying default data into /data..."
  cp -r "$CLONE_DIR/data/"* "$DATA_DIR/"
fi

# Only fetch JAGs if needed
if [ ! -f "$DATA_DIR/config.jag" ] || [ ! -f "$DATA_DIR/maps.jag" ]; then
  echo "🎮 Fetching JAG files into /data..."
  chmod +x "$DATA_DIR/fetch-jag-files.sh"
  cd "$DATA_DIR"
  ./fetch-jag-files.sh
fi

# Launch the server from the repo root
cd "$CLONE_DIR"
echo "🚀 Launching server..."
exec ./src/rscsundae -b "$DATA_DIR"