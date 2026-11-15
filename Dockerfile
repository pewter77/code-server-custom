FROM ghcr.io/linuxserver/code-server:version-4.145.2

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
        https://github.com/getsops/sops/releases/download/v3.13.1/sops-v3.13.1.linux.amd64 && \
    chmod +x /usr/local/bin/sops

# Gitea MCP server (lets Claude Code open PRs and read issues on Gitea).
# The checksum is the one published in the release's checksums.txt.
RUN curl -fsSLo /tmp/gitea-mcp.tar.gz \
        https://gitea.com/gitea/gitea-mcp/releases/download/v1.13.0/gitea-mcp_Linux_x86_64.tar.gz && \
    echo "23383ad6adbb7a8a6a848ac736c07de19417d26311c3581160b356db01b3366d  /tmp/gitea-mcp.tar.gz" | sha256sum -c - && \
    tar -xzf /tmp/gitea-mcp.tar.gz -C /usr/local/bin gitea-mcp && \
    rm /tmp/gitea-mcp.tar.gz

RUN pip3 install --break-system-packages \
        ansible \
        ansible-lint

RUN npm install -g @anthropic-ai/claude-code
