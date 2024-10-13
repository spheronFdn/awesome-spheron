# Use NVIDIA's official CUDA runtime as a parent image with Ubuntu 22.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set environment variable to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites and Python 3.10
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    git \
    curl \
    tzdata \
    python3-pip \
    nano \
    libgl1 \
    npm \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-all-dev \
    libatlas-base-dev \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install pm2 globally
RUN npm install pm2@latest -g

# Install Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set Python3.10 as the default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Set the working directory in the container
WORKDIR /app

# Clone the bitmind repository
RUN git clone https://github.com/bitmind-ai/bitmind-subnet.git .

# Install bitmind requirements
RUN pip install --no-cache-dir -r requirements-miner.txt && \
    pip install --no-cache-dir dlib==19.24.0 && \
    pip install -e .

COPY btcli-install.sh /tmp/btcli-install.sh
RUN sed -i 's/sudo //g' /tmp/btcli-install.sh && \
    chmod +x /tmp/btcli-install.sh && \
    bash /tmp/btcli-install.sh && \
    rm /tmp/btcli-install.sh

# Copy the wallet setup script
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# Set CUDA_HOME environment variable
ENV CUDA_HOME /usr/local/cuda
ENV HF_REPO_ID ""
ENV AVG_LOSS_UPLOAD_THRESHOLD ""

# Expose Code Server port
EXPOSE 8080

# Define the command to run the startup script and Code Server
CMD ["/bin/bash", "-c", "/app/startup.sh & code-server --auth none --bind-addr 0.0.0.0:8080"]
