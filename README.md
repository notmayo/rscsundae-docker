# 🧁 Runescape Classic Sundae - Containerized Server

A clean, auto-updating Docker container for [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) — a RuneScape Classic server emulator written in C99. This container pulls the latest version of the project on **every container start**, compiles it, and launches the server! 🎮

---

## 🚀 Features

- 🧠 **Auto-updates** from the upstream Git repo on startup
- 🛠️ **Auto-builds** the latest version inside the container
- 💾 Uses a **bind mount** (`/your/path:/data`) to persist world data
- ⚠️ Warns if no `/data` mount is provided
- 🎮 Exposes RuneScape Classic port `43594`

---

## 🧰 Requirements

- Docker (and optionally Docker Compose)
- A local folder to persist your server data

---

## 🏗️ Build the Image

```bash
git clone https://git.sr.ht/~stormy/rscsundae
cd rscsundae
docker build -t rscsundae .
