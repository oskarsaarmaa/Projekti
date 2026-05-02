# Infrastructure-as-Code: Automated Monitoring Stack 

This repository demonstrates a fully automated Infrastructure-as-Code (IaC) solution using **SaltStack** to provision a robust monitoring environment. It automatically installs and configures Docker, Prometheus, and Grafana on a clean Debian-based system.

## 📖 Project Overview

The goal of this project is to replace manual, error-prone server configurations with a standardized, idempotent, and scalable automated process. By defining the infrastructure as code, any IT team member can deploy a fully functional monitoring stack in minutes rather than hours.

### Key Technologies Used:
* **SaltStack:** For configuration management and automation.
* **Docker:** For containerized application deployment.
* **Prometheus:** For metrics collection and system monitoring.
* **Grafana:** For data visualization and analytics.
* **Bash:** For bootstrapping the initial Salt environment.

## 💼 Business Value

Why is this setup valuable for an organization?

1. **Time Efficiency & Scalability:** A completely automated pipeline reduces server setup time from hours to mere minutes. The same command can provision 1 or 100 servers simultaneously.
2. **Idempotency & Reliability:** SaltStack continuously ensures the system matches the desired state. If a container is accidentally removed, running the automation will automatically restore it without breaking existing configurations.
3. **Standardization:** Eliminates the "it works on my machine" problem. Every server provisioned with this code will be identical, making troubleshooting and onboarding significantly easier.
4. **Proactive Monitoring:** Instantly provides the business with visibility into their infrastructure health via Prometheus and Grafana, preventing costly downtime.

##  Repository Structure

The project is structured according to SaltStack best practices, keeping states modular and easy to maintain.
```text
.
├── LICENSE
├── README.md
├── install_salt.sh           # Automated bootstrap script
└── srv/
    └── salt/
        ├── top.sls           # State tree entry point
        ├── docker/
        │   └── init.sls      # Docker installation state
        ├── grafana/
        │   └── init.sls      # Grafana container state
        └── prometheus/
            ├── init.sls      # Prometheus container state
            └── prometheus.yml # Prometheus configuration file
```

##  How to Deploy (Quickstart)

This project features a "turnkey" deployment. You do not need to manually install dependencies or configure state files.

### Prerequisites
* A clean Debian-based Linux environment (tested on Debian Trixie).
* `sudo` privileges.

### Deployment Steps
**1. Clone the repository:**
```bash
git clone [https://github.com/YOUR_USERNAME/Projekti.git](https://github.com/YOUR_USERNAME/Projekti.git)
cd Projekti
```

**2. Run the automated installer:**
```bash
sudo bash install_salt.sh
```

**What the script does under the hood:**
* Updates the system and installs necessary base tools (Python venv, git, pip).
* Installs Salt and the Docker Python SDK.
* Sets up the `/srv/salt` directory and copies the configuration files.
* Executes the Salt automation (`sudo salt-call --local state.apply`).

##  Verification

Once the script finishes, you should see a Salt summary indicating **0 failures** (e.g., `Succeeded: 7, Failed: 0`). 

The monitoring services will immediately be available at:
* **Grafana:** `http://localhost:3000`
* **Prometheus:** `http://localhost:9090`

*(Note: If you are deploying this on a remote virtual machine, replace `localhost` with the VM's IP address).*
