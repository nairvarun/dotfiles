FROM nicolaka/netshoot:latest

# ── AWS CLI v2 (static binary, no Python needed) ──────────────────────────────
# AWS CLI v2 ships as a self-contained binary on Linux, no Python runtime required
RUN apk add --no-cache gcompat libstdc++ \
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# ── Node.js (latest LTS via official Alpine package) ──────────────────────────
RUN apk add --no-cache nodejs npm

# ── pi coding agent ────────────────────────────────────────────────────────────
RUN npm install -g @mariozechner/pi-coding-agent

# ── kubectl ────────────────────────────────────────────────────────────────────
RUN curl -fsSL "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')/kubectl" \
      -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# ── SSH client ─────────────────────────────────────────────────────────────────
# openssh-client is likely already in netshoot, this is a no-op if so
RUN apk add --no-cache openssh-client \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh

# ── AWS credentials from host ──────────────────────────────────────────────────
# ~/.aws/agent-credentials on host → ~/.aws/credentials in container
# Handled at runtime via volume mount (see run command below)

# ── Environment ────────────────────────────────────────────────────────────────
ENV EDITOR=vim

WORKDIR /workspace

CMD ["zsh"]
