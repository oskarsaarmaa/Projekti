# Asennetaan Docker-paketit järjestelmän pakethallinnasta
install_docker_packages:
  pkg.installed:
    - pkgs:
      - docker.io
      - docker-compose

# Varmistetaan, että Docker-palvelu on käynnissä ja aktivoitu käynnistymään bootissa
docker_service_enabled:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: install_docker_packages
