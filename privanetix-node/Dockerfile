FROM privasea/acceleration-node-beta:latest

# Copy custom entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Override the base image's entrypoint
ENTRYPOINT ["/entrypoint.sh"]
