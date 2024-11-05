# Start from the Ray ML CPU nightly image
FROM rayproject/ray-ml:nightly-cpu

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gpg \
    nginx \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY start.sh /app/start.sh

# Create a startup script
RUN chmod +x /app/start.sh

# Set the startup script as the entry point
ENTRYPOINT ["/app/start.sh"]