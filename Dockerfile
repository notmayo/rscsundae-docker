FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
  argon2-dev \
  autoconf \
  automake \
  bash \
  bzip2-dev \
  build-base \
  curl \
  git \
  inih-dev \
  lua5.4-dev \
  netcat-openbsd \
  openssl-dev \
  pkgconf \
  sqlite-dev

# Create app directory
WORKDIR /opt/rscsundae

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose game server port
EXPOSE 43594

# Healthcheck on port 43594
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s CMD nc -z localhost 43594 || exit 1

# Run the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
