# Infrastructure-as-Code: Automated Monitoring Stack 

This repository provides a production-ready Infrastructure-as-Code (IaC) solution to provision a fully containerized monitoring environment. Utilizing **SaltStack**, the project automates the deployment of a complete stack including Docker, Prometheus, and Grafana on Debian-based systems.

## 📖 Table of Contents
* [Project Overview](#project-overview)
* [Architecture & Tools](#architecture--tools)
* [Business Value](#business-value)
* [Technical Implementation](#technical-implementation)
* [Repository Structure](#-repository-structure)
* [Installation & Deployment](#-installation--deployment)
* [Verification & Results](#-verification--results)

---

##  Project Overview

The objective of this project is to eliminate manual configuration drift and "snowflake servers" by defining the entire monitoring infrastructure as code. This project demonstrates how a single entry point can transform a bare Linux installation into a fully monitored node with standardized configurations.

### The "One-Touch" Philosophy
Instead of following a manual 20-step installation guide, this project uses a bootstrap script to prepare the environment and SaltStack to enforce the final state. This ensures **idempotency**: running the setup multiple times will always result in the same, correct configuration without side effects.

---

## Achitecture & Tools

The system is built on a modular architecture where SaltStack acts as the orchestrator for Docker-based microservices.

*   **Orchestrator:** [SaltStack](https://docs.saltproject.io/) - Handles package management, file distribution, and service states.
*   **Engine:** [Docker](https://www.docker.com/) - Provides the isolation layer for services.
*   **Metrics:** [Prometheus](https://prometheus.io/) - Time-series database for pulling and storing metrics.
*   **Visualization:** [Grafana](https://grafana.com/) - The analytics platform for building monitoring dashboards.

---

##  Business Value

In a modern IT environment, this approach provides several critical advantages:

1.  **Disaster Recovery:** If a monitoring server fails, a replacement can be fully provisioned in under 5 minutes using the code in this repository.
2.  **Configuration Consistency:** Ensures that Prometheus configuration (`prometheus.yml`) is identical across all environments (Dev/Test/Prod).
3.  **Reduced OpEx:** Automation removes the need for highly manual maintenance tasks, allowing the IT team to focus on development rather than "firefighting" infrastructure issues.
4.  **Compliance:** Every change is tracked via Git, providing an audit trail of who changed the infrastructure and when.

---

##  Technical Implementation

### SaltStack State Tree
The project follows the "Top File" pattern to manage the state tree:
*   **`top.sls`**: The map that assigns roles to the server.
*   **Modular States**: Each service (Docker, Prometheus, Grafana) has its own directory with an `init.sls` file, making the system easy to extend.

### Bootstrap Process
The `install_salt.sh` script bridges the gap between a raw OS and a managed node:
1.  **Dependency Resolution**: Installs `pip` and required Python SDKs for Docker integration.
2.  **Salt-Call Local**: Utilizes a masterless Salt setup, perfect for individual node management or edge computing.

---

##  Repository Structure
```text
.
├── LICENSE                   # GNU General Public License v3.0
├── README.md                 # Project documentation
├── install_salt.sh           # Main automated bootstrap script
└── srv/
    └── salt/                 # SaltStack root directory
        ├── top.sls           # Master state file
        ├── docker/
        │   └── init.sls      # State: System-level Docker installation
        ├── grafana/
        │   └── init.sls      # State: Grafana container & port mapping
        └── prometheus/
            ├── init.sls      # State: Prometheus container & config sync
            └── prometheus.yml # Pre-defined Prometheus configuration
```

---

##  Installation & Deployment

### Prerequisites
* **OS:** Debian 12 (Bookworm) or Debian Trixie.
* **Privileges:** Sudo access.
* **Network:** Internet access for pulling Docker images.

### Deployment Steps
```bash
# 1. Clone the repository
git clone [https://github.com/YOUR_USERNAME/Projekti.git](https://github.com/YOUR_USERNAME/Projekti.git)
cd Projekti

# 2. Execute the turnkey installer
sudo bash install_salt.sh
```

---

##  Verification & Results

After a successful run, Salt will report `Succeeded: 7, Failed: 0`. You can then access the web interfaces:

| Service | URL | Default Port |
| :--- | :--- | :--- |
| **Grafana** | `http://localhost:3000` | 3000 |
| **Prometheus** | `http://localhost:9090` | 9090 |

### Final Result Screenshot
![Monitoring Dashboard](./screenshot.png) 
*(Note: Replace the path above with your actual screenshot file)*

---
**Author:** [Your Name]  
**Course:** Configuration Management 2026

##  References

The following resources were instrumental in the development of this project:

*   **SaltStack Documentation:** [Salt Project Documentation](https://docs.saltproject.io/en/latest/contents.html) - Used for state file (SLS) syntax and `salt-call` local execution.
*   **Prometheus Configuration:** [Prometheus.io Docs](https://prometheus.io/docs/introduction/overview/) - Reference for `prometheus.yml` structure and metrics collection.
*   **Docker Hub:** [Official Grafana Image](https://hub.docker.com/r/grafana/grafana) & [Official Prometheus Image](https://hub.docker.com/r/prom/prometheus) - For container environment variables and port mappings.
*   **Tero Karvinen's Infrastructure as Code:** [terokarvinen.com](https://terokarvinen.com) - Conceptual framework for centralized management and SaltStack best practices.
*   **Debian Trixie (Testing) Release Notes:** Used to verify Python and Pip compatibility for the bootstrap script.
