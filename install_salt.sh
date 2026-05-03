#!/bin/bash

REPO_URL="https://github.com/oskarsaarmaa/Projekti.git"
TARGET_DIR="$HOME/Projekti"

echo "--- Starting automated installation ---"

# 1. Check if we have the repository files locally. 
# If not, clone them to ensure the script has everything it needs.
if [ ! -d "$TARGET_DIR/srv" ]; then
    echo "Local files not found. Cloning repository to $TARGET_DIR..."
    git clone $REPO_URL $TARGET_DIR
    cd $TARGET_DIR
else
    echo "Repository files found locally at $TARGET_DIR."
fi

# 2. Update the system and install base tools
sudo apt-get update
sudo apt-get install -y python3-pip python3-venv git

# 3. Install Salt and the Docker interface
# --break-system-packages is required for modern Debian/Ubuntu
echo "Installing Salt and required Python libraries..."
sudo pip3 install salt docker --break-system-packages

# 4. Setup the Salt directory structure
sudo mkdir -p /srv/salt

# 5. Copy configurations to the system (The Salt Root)
echo "Copying Salt configurations to /srv/salt/..."
sudo cp -r srv/salt/* /srv/salt/

# 6. Run the automation
echo "Executing automation (state.apply)..."
sudo salt-call --local --file-root=/srv/salt state.apply

echo "--- Installation complete! ---"
echo "Grafana: http://localhost:3000"
echo "Prometheus: http://localhost:9090"
