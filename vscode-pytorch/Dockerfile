# Start with NVIDIA CUDA base image
FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create a non-root user
RUN useradd -m -s /bin/bash coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# Install PyTorch with CUDA support
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Set environment variables
ENV PUID=1000
ENV PGID=1000
ENV TZ=Etc/UTC
ENV PASSWORD=password
ENV DEFAULT_WORKSPACE=/config/workspace

# Update user permissions to match PUID/PGID
RUN groupmod -o -g $PGID coder && \
    usermod -o -u $PUID coder && \
    mkdir -p /config/workspace && \
    chown -R coder:coder /config

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Switch to non-root user
USER coder
WORKDIR ${DEFAULT_WORKSPACE}

# Expose code-server port
EXPOSE 8080

# Start code-server with password authentication
CMD ["sh", "-c", "code-server --bind-addr 0.0.0.0:8080 --auth password"] 