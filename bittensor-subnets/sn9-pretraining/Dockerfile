# Use NVIDIA's official CUDA runtime as a parent image with Ubuntu 22.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set environment variable to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites and Python 3.9
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    git \
    curl \
    tzdata \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y \
    python3.9 \
    python3.9-venv \
    python3.9-dev \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set Python3.9 as the default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# Set the working directory in the container
WORKDIR /app

# Clone the repository with a specific tag
RUN git clone https://github.com/rekpero/pretraining.git .

# Upgrade pip and install Python dependencies
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir packaging wheel torch 

# Install the current package in editable mode
RUN pip install --no-cache-dir -e .
# RUN pip install --upgrade bittensor bittensor-cli

# Install expect
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




