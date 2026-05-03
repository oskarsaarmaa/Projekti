# Automated Monitoring Stack with SaltStack

This is a project we built together to automate the setup of a monitoring environment. It uses SaltStack to install Docker and then runs Prometheus and Grafana in containers. We made this as a pair project to replace manual installation steps with a single automated process.

## Project Goal

The main idea for us was to learn how to manage infrastructure as code. Instead of installing everything by hand, we wrote a script and Salt states that do the work for us. This makes sure that the setup is the same every time and we don't forget any steps during the installation.

## What we used

*   **SaltStack:** This was our main tool for automation. It handles the configurations and makes sure the services are running.
*   **Docker:** All the monitoring tools run inside Docker containers to keep them isolated from the host system.
*   **Prometheus:** We used this for collecting metrics from the system.
*   **Grafana:** We used this for visualizing the data collected by Prometheus.

## Why this is useful

Even though this is a relatively small project, we feel this approach is really important in real IT work:
1.  **Speed:** Setting up a new monitoring server now takes us minutes instead of hours.
2.  **Consistency:** The configuration is always the same because we defined it in the code.
3.  **Teamwork:** Working as a pair helped us solve problems faster and double-check each other's configurations.

## How it works (Technical details)

### The Bootstrap Script
We wrote a bash script called `install_salt.sh`. It handles the "boring" parts like installing Salt, Python dependencies (like the Docker SDK), and moving the configuration files to the correct `/srv/salt` directory. 

### Salt States
We divided the project into small, manageable modules:
*   **Docker:** Handles the Docker engine installation.
*   **Prometheus:** Pulls the image, sets up our `prometheus.yml` config, and starts the container.
*   **Grafana:** Sets up the Grafana container and maps the necessary ports.

**Note for developers:** We learned the hard way that Salt is extremely picky about YAML indentation. While working on this, we spent quite a bit of time fixing rendering errors caused by single missing spaces!

## Files in this Repo
```text
.
├── LICENSE                   # GNU GPL v3.0
├── README.md                 # This file
├── install_salt.sh           # The script that starts everything
└── srv/
    └── salt/                 # Salt files
        ├── top.sls           # The "map" for Salt
        ├── docker/           # Docker setup
        ├── grafana/          # Grafana setup
        └── prometheus/       # Prometheus setup and config
```

## How to run it

### Prerequisites
*   A clean Debian-based system (We used Debian Trixie/Testing).
*   Sudo rights.

### Steps
1.  **Clone the repo:**
    ```bash
    git clone [https://github.com/oskarsaarmaa/Projekti.git](https://github.com/oskarsaarmaa/Projekti.git)
    cd Projekti
    ```

2.  **Run the installer:**
    ```bash
    sudo bash install_salt.sh
    ```

3.  **Check if it worked:**
    Run `sudo docker ps` to see if the containers are up and running.

## Results

When the script finishes successfully, Salt should report `Succeeded: 7`. You can then open the web interfaces:
*   **Grafana:** http://localhost:3000 (Default login: admin / admin)
*   **Prometheus:** http://localhost:9090

### Screenshot of our working setup
![Final result](./screenshot.png)

---

## Sources
*   Salt Project official documentation
*   Prometheus and Grafana Docker Hub pages
*   Tero Karvinen's course materials (terokarvinen.com)

**Authors:** Oskar Saarmaa & Miro Rautanen
