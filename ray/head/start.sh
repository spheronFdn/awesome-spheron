#!/bin/bash

# Start Jupyter Notebook
jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root &

# Start VS Code Server
code-server --bind-addr 0.0.0.0:8080 --auth none /workspace &

# Set the Grafana host to use the pod's IP address
# POD_IP=$(hostname -i)
# export RAY_GRAFANA_HOST="http://${POD_IP}:3000"

# Start Ray with metrics enabled
ray start --head --port=6379 --dashboard-port=8265 --dashboard-host=0.0.0.0 --metrics-export-port=8080 --include-dashboard=true --block

# if [ -z "${RAY_GRAFANA_HOST}" ]; then
#     # Launch Prometheus
#     ray metrics launch-prometheus
#     echo "Ray is configured to access Grafana at: ${RAY_GRAFANA_HOST}"

#     # Start Grafana with Ray's configuration
#     /usr/sbin/grafana-server --config /tmp/ray/session_latest/metrics/grafana/grafana.ini --homepath /usr/share/grafana web &

#     # Wait for Grafana to start
#     echo "Waiting for Grafana to start..."
#     for i in {1..30}; do
#         if curl -s -o /dev/null -w "%{http_code}" "${RAY_GRAFANA_HOST}/api/health" | grep -q "200"; then
#             echo "Grafana is up and running"
#             break
#         fi
#         if [ $i -eq 30 ]; then
#             echo "Grafana failed to start within the expected time"
#         fi
#         sleep 2
#     done

#     # Test Grafana access from within the container
#     echo "Testing Grafana access from within the container:"
#     curl -v "${RAY_GRAFANA_HOST}/api/health"
# fi

# Keep the script running
# tail -f /dev/null