# Create a folder for the config file on the host machine
prometheus_config_dir:
  file.directory:
    - name: /etc/prometheus
    - user: root
    - group: root
    - mode: 755

# Copy our prometheus.yml to the host folder
manage_prometheus_yml:
  file.managed:
    - name: /etc/prometheus/prometheus.yml
    - source: salt://prometheus/prometheus.yml
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: prometheus_config_dir

# Run Prometheus container and mount the config file from the host
run_prometheus_container:
  cmd.run:
    - name: |
        docker run -d \
          --name prometheus \
          --restart always \
          -p 9090:9090 \
          -v /etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
          prom/prometheus
    - unless: docker ps -a | grep prometheus
