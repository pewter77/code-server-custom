FROM ghcr.io/linuxserver/code-server:version-4.113.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        age \
        nodejs \
        npm \
        python3-pip \
        python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSLo /usr/local/bin/sops \
        https://github.com/getsops/sops/releases/download/v3.9.4/sops-v3.9.4.linux.amd64 && \
    chmod +x /usr/local/bin/sops

RUN pip3 install --break-system-packages \
        ansible \
        ansible-lint

RUN npm install -g @anthropic-ai/claude-code
