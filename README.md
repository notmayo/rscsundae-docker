# 🧁 RSC Sundae Docker

A self-updating Docker container for [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) — a RuneScape Classic server emulator written in C99.  
This container automatically clones, builds, and launches the server on startup. 🎮

---

## 🚀 Features

- 🔁 Pulls and builds the latest version on **every container start**  
- 💾 Uses a bind mount (`/your/local/path/data:/data`) to persist all game/world data  
- ⚠️ Detects missing `/data` mounts  
- 🧠 Warns users if `-it` is missing (required for server startup)  
- 🎮 Exposes RuneScape Classic server port `43594` by default  
- ❤️ Includes a lightweight `HEALTHCHECK`  

---

## 🧰 Requirements

- Docker (Linux/macOS/Windows with WSL2)
- A local folder to persist your server data

---

## 🏗️ Build the Image

Clone this Docker wrapper and build the container image:

```bash
git clone https://github.com/notmayo/rscsundae-docker
cd rscsundae-docker
docker build -t rscsundae .
```

---

## ▶️ Run the Container

### ✅ With a bind mount

```bash
docker run -it -p 43594:43594 -v /your/local/path/data:/data rscsundae
```

> ⚠️ The server will refuse to start if `-it` is not passed.  
> Use `-it` to ensure proper terminal handling.

---

## 🔁 Using Docker Compose

```yaml
version: "3.8"
services:
  rscsundae:
    image: notmayo/rscsundae-docker:latest
    container_name: rscsundae
    ports:
      - "43594:43594"
    volumes:
      - /your/local/path/data:/data
    stdin_open: true   # Ensures interactive mode (-it)
    tty: true
    restart: unless-stopped
```

Start it with:

```bash
docker compose up
```

---

## 📂 Data Directory

Your `/data` volume stores everything needed to persist your game world:

- `settings.ini`
- `rsc.sqlite` + WAL files
- `config.jag`, `maps.jag`
- `schema.sql`, `fetch-jag-files.sh`

> 💡 Back this folder up regularly!

---

## 🧊 Credits

- 🍦 [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) by stormy  

---

## 🧃 License

This project wraps an upstream open-source emulator.  
Check the original [RSC Sundae](https://git.sr.ht/~stormy/rscsundae) repository for licensing details.
