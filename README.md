# Grafana Loki + Alloy Stack on Ubuntu (Docker)

This repository contains a complete, production-ready (development-tuned) observability stack for log aggregation using **Grafana**, **Loki**, and **Alloy** (the successor to Promtail). It is optimized for running on **Ubuntu** within **VMware Workstation**.



## 🚀 Features
- **Loki 3.0**: High-performance log storage.
- **Grafana Alloy**: The new unified agent for telemetry collection.
- **Automated Provisioning**: Grafana comes pre-configured with the Loki datasource.
- **Log Sources**: Automatically collects Docker container logs and Ubuntu system logs (`syslog`, `auth.log`, etc.).
- **Flog**: Includes a dummy log generator for immediate testing.

## 🛠 Prerequisites
- Ubuntu 20.04 LTS or newer.
- Docker & Docker Compose installed.
- Minimum 4GB RAM, 2 CPU cores.

## 📦 Installation

### 1. Clone the repository
```bash
git clone [https://github.com/acejkt/grafana-loki-alloy-docker-ubuntu-latest.git](https://github.com/acejkt/grafana-loki-alloy-docker-ubuntu-latest.git)
cd grafana-loki-alloy-docker-ubuntu-latest