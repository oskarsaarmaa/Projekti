grafana_image:
  docker_image.present:
    - name: grafana/grafana:latest
grafana_container:
  docker_container.running:
    - name: grafana
    - image: grafana/grafana:latest
    - port_bindings:
      - 3000:3000
