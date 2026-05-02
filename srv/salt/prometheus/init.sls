# Varmistetaan, että konfiguraatiolle on hakemisto isäntäkoneella
prometheus_config_dir:
  file.directory:
    - name: /etc/prometheus
    - user: root
    - group: root
    - mode: 755

# Kopioidaan konfiguraatiotiedosto GitHub-kansiosta (Salt-hakemistosta) järjestelmään
# Tämä on idempotentti: tiedosto kopioidaan vain, jos se on muuttunut
manage_prometheus_yml:
  file.managed:
    - name: /etc/prometheus/prometheus.yml
    - source: salt://prometheus/prometheus.yml
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: prometheus_config_dir

# Käynnistetään Prometheus-kontti Dockerilla
# 'unless' tekee tästä idempotentit: komentoa ei ajeta, jos kontti on jo käynnissä
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
