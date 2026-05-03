# Install docker and docker-compose packages
install_docker_packages:
  pkg.installed:
    - pkgs:
      - docker.io
      - docker-compose

# Make sure docker service is running and starts on boot
docker_service_enabled:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: install_docker_packages
