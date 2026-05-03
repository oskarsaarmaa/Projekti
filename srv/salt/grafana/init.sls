# Download the latest Grafana image
grafana_image:
  docker_image.present:
    - name: grafana/grafana:latest

# Run Grafana container and map it to port 3000
grafana_container:
  docker_container.running:
    - name: grafana
    - image: grafana/grafana:latest
    - port_bindings:
      - 3000:3000
