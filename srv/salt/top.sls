# This is the main entry point for our automation.
# It tells Salt to apply these modules to all nodes ('*').
base:
  '*':
    - docker
    - prometheus
    - grafana
