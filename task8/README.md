# Week 8: Monitoring Stack (Prometheus & Grafana)

##  Overview
In this task, I deployed a complete **Monitoring Stack** using Docker Compose. The goal was to visualize system metrics (CPU, RAM, Disk) in real-time.

##  Tech Stack
* **Prometheus:** The database that collects metrics.
* **Node Exporter:** The agent that reads Linux system stats.
* **Grafana:** The dashboard that visualizes the data.
* **Docker Compose:** Orchestrates all three containers.

##  Configuration Files
* **`docker-compose.yml`**: Defines the 3 services (`prometheus`, `grafana`, `node-exporter`).
* **`prometheus.yml`**: Configures Prometheus to scrape data from itself and the Node Exporter.

##  1.Dashboard Setup
I imported **Grafana Dashboard ID 1860** (Node Exporter Full) to visualize:
* CPU Usage (Gauge)
* RAM/Memory Usage (Pie Chart)
* Network Traffic (Graph)
* Disk I/O

##  How to Run
1. **Start the Stack:**
   ```bash
   docker compose up -d
## 2.Access Interfaces:

    Prometheus: http://localhost:9090

    Grafana: http://localhost:3000 (Login: admin/admin)
## 3.Stop the Stack:

docker compose down
