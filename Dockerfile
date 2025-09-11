# Dockerfile — intentionally insecure / legacy environment for testing only
# WARNING: use only in an isolated sandbox (--network=none), never in production.

# Extremely old base (lots of legacy libs)
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install legacy system packages and build tools (old versions available in this base)
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
      wget curl ca-certificates build-essential python python-dev python-pip \
      openssh-server nginx php5 php5-cli php5-mysql mysql-client \
      vim less net-tools iputils-ping sudo unzip git \
    && rm -rf /var/lib/apt/lists/*

# Install an old Node.js (example using Node v0.10 binary tarball)
# NOTE: node 0.10 images existed historically; if this fetch fails you can substitute another old node base
RUN set -eux; \
    NODE_VERSION="0.10.48"; \
    wget -q "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" -O /tmp/node.tar.gz || true; \
    if [ -f /tmp/node.tar.gz ]; then \
      tar -xzf /tmp/node.tar.gz -C /usr/local --strip-components=1; \
    fi; \
    npm config set unsafe-perm true || true; \
    npm -v || true; node -v || true

# Copy your intentionally vulnerable package.json and index (you already created package.json)
COPY package.json /app/package.json
COPY index.js /app/index.js

# Install node modules (this will pull many vulnerable packages)
# Install in non-networked builds you must ensure access; recommended run with network disabled in lab environment
RUN if command -v npm >/dev/null 2>&1; then npm install --no-audit --no-fund || true; fi

# Add some legacy tools & create a user (runs as root — intentionally insecure)
RUN useradd -m -s /bin/bash vuln && \
    echo "vuln ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Example of enabling SSH (insecure) — for testing only (SSH daemon not configured securely)
RUN mkdir /var/run/sshd
EXPOSE 22 80 3000 3306

# Start a trivial command so container stays alive for scanning / manual inspection.
CMD ["/bin/bash", "-c", "echo 'Container started (intentionally insecure). Use only in isolated lab.' && tail -f /dev/null"]
