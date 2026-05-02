#!/bin/bash

echo "--- Starting automated installation ---"

# 1. Update the system and install base tools
sudo apt-get update
sudo apt-get install -y python3-pip python3-venv git

# 2. Install Salt and the Docker interface (Debian Trixie compatibility)
# --break-system-packages is required for pip installations on modern Debian
echo "Installing Salt and required Python libraries..."
sudo pip3 install salt docker --break-system-packages

# 3. Create the Salt directory structure if it doesn't exist
sudo mkdir -p /srv/salt

# 4. Copy configurations from this repository to the system
# This assumes the script is run from the root of the cloned repository
echo "Copying Salt configurations to /srv/salt/..."
sudo cp -r srv/salt/* /srv/salt/

# 5. Run the Salt automation (state.apply)
echo "Executing automation (state.apply)..."
sudo salt-call --local --file-root=/srv/salt state.apply

echo "--- Installation complete! ---"
echo "Grafana is available at: http://localhost:3000"
echo "Prometheus is available at: http://localhost:9090"
