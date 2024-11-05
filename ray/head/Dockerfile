# Start from the Ray ML CPU nightly image
FROM rayproject/ray-ml:nightly-cpu

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gpg \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter Notebook
RUN pip install jupyter

# Install VS Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install Grafana
RUN wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - \
    && echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list \
    && apt-get update && apt-get install -y grafana \
    && rm -rf /var/lib/apt/lists/*

# Set up a working directory
WORKDIR /workspace

# Expose ports for Jupyter (8888), and VS Code (8080)
EXPOSE 8888 8080 3000

COPY start.sh /start.sh

# Create a startup script
RUN chmod +x /start.sh

# Set the startup script as the entry point
ENTRYPOINT ["/start.sh"]