#!/bin/bash

# Start Jupyter Notebook
jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root &

# Start VS Code Server
code-server --bind-addr 0.0.0.0:8080 --auth none /workspace &

# Set the Grafana host to use the pod's IP address
# POD_IP=$(hostname -i)
# export RAY_GRAFANA_HOST="http://${POD_IP}:3000"

# Start Ray with metrics enabled
ray start --head --node-ip-address $GATEWAY_IP --port=$TUNNEL_PORT_6379 --dashboard-port=$TUNNEL_PORT_8265 --dashboard-host=0.0.0.0 --include-dashboard=true  --dashboard-grpc-port=$TUNNEL_PORT_8006  --ray-client-server-port=$TUNNEL_PORT_10001 --object-manager-port=$TUNNEL_PORT_8000 --node-manager-port=$TUNNEL_PORT_8001 --runtime-env-agent-port=$TUNNEL_PORT_8002 --dashboard-agent-grpc-port=$TUNNEL_PORT_8003 --dashboard-agent-listen-port=$TUNNEL_PORT_8004 --metrics-export-port=$TUNNEL_PORT_8005 --worker-port-list $TUNNEL_PORT_8007,$TUNNEL_PORT_8008,$TUNNEL_PORT_8009,$TUNNEL_PORT_8010,$TUNNEL_PORT_8011,$TUNNEL_PORT_8012,$TUNNEL_PORT_8013,$TUNNEL_PORT_8014,$TUNNEL_PORT_8015,$TUNNEL_PORT_8016,$TUNNEL_PORT_8017,$TUNNEL_PORT_8018,$TUNNEL_PORT_8019,$TUNNEL_PORT_8020 --block

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