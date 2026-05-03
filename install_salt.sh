#!/bin/bash

echo "Starting automated installation"

# 1. Update the system and install basic tools needed for the setup
sudo apt-get update
sudo apt-get install -y python3-pip python3-ven git

# 2. Install Salt and the Docker library for Salt
# Note: --break-system-packages is used for compatibility with modern Debian/Ubuntu versions
echo "Installing Salt and required Python libraries"
sudo pip3 install salt docker --break-system-packages

# 3. Setup the Salt directory where everything will be managed
sudo mkdir -p /srv/salt

# 4. Copy configuration files from this project folder to the system root
# This makes our SLS files available for Salt
echo "Copying Salt configurations to /srv/salt/..."
sudo cp -r srv/salt/* /srv/salt/

# 5. Run the automation using salt-call
# This applies all the states defined in our top.sls
echo "Executing automation"
sudo salt-call --local --file-root=/srv/salt state.apply

echo "Installation complete!"
echo "Grafana is available at: http://localhost:3000"
echo "Prometheus is available at: http://localhost:9090"
