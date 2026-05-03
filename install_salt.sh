#!/bin/bash

# This script automates the installation of SaltStack and the Docker-based monitoring stack.
# Usage: sudo bash install_salt.sh

echo "Starting automated installation "

# 1. Update package lists and install essential base tools
# Including git to ensure it's available for any further operations.
sudo apt-get update
sudo apt-get install -y python3-pip python3-venv git

# 2. Install Salt and the Docker library for Salt
# Note: --break-system-packages is required for compatibility with modern Debian-based systems (e.g., Debian Trixie).
echo "Installing Salt and required Python libraries"
sudo pip3 install salt docker --break-system-packages

# 3. Create the directory structure for Salt configurations
# This is the default path where salt-call looks for state files.
sudo mkdir -p /srv/salt

# 4. Copy project SLS files to the system's Salt root
# This assumes the script is executed from within the 'Projekti' directory.
echo "Copying Salt configurations to /srv/salt/"
sudo cp -r srv/salt/* /srv/salt/

# 5. Execute the automation (State Apply)
# Running in local mode (--local) to avoid the need for a separate Salt-Master.
echo "Executing automation (state.apply)"
sudo salt-call --local --file-root=/srv/salt state.apply

echo ""
echo "Installation complete!"
echo "Grafana is available at: http://localhost:3000"
echo "Prometheus is available at: http://localhost:9090"
