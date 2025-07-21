# 🧁 RSC Sundae Docker

A clean, auto-updating Docker container for [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) — a RuneScape Classic server emulator written in C99. This container pulls the latest version of the project on **every container start**, compiles it, and launches the server! 🎮

## 🚀 Features

- 🧠 Auto-updates from the upstream Git repo on startup  
- 🛠️ Auto-builds the latest version inside the container  
- 💾 Uses a bind mount (`/your/path:/data`) to persist world data  
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
```

---

## ▶️ Run the Container

### ✅ With a bind mount (recommended)

```bash
docker run -p 43594:43594 -v /your/local/path:/data rscsundae
```

### ⚠️ Without a mount

```bash
docker run -p 43594:43594 rscsundae
```

> ⚠️ If you don't mount `/data`, the container will warn you and use internal storage.  
> **Game data will be lost when the container stops!**

---

## 🔁 Using Docker Compose

```bash
version: "3.8"
services:
  sundae:
    build: .
    ports:
      - "43594:43594"
    volumes:
      - /your/local/path:/data
    restart: unless-stopped
```

Start it with:

```bash
docker compose up --build
```

---

## 📂 Data Directory

Your `/data` mount stores everything needed to persist your world state.  
Back it up regularly!

---

## 🧊 Credits

- 🍦 [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) by stormy — clean-room RuneScape Classic emulator in C99  
- 🐳 Docker container by [your name here]

---

## 🧃 License

This project wraps an upstream open-source emulator.  
Check the original [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) repository for licensing details.
