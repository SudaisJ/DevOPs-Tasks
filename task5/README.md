# Week 5: Kubernetes Basics (Deployment & Services)

## 🚀 Overview
In this task, I set up a local Kubernetes cluster using **Minikube** and deployed a scalable, self-healing web application. I also explored **Lens IDE** for visual management and performed real-world DevOps operations like scaling and zero-downtime rolling updates.

## 🛠️ Tech Stack
* **Orchestration:** Kubernetes (Minikube)
* **Visualization:** Lens Desktop App
* **Web Server:** Nginx (Migrated to Apache/httpd)
* **OS:** Kali Linux

## 📂 Project Files
* **`deployment.yaml`**: Defines the "Manager" that ensures 3 replicas of the web server are always running.
* **`service.yaml`**: Defines the "Receptionist" (NodePort) that exposes the app to the browser on port `30005`.

---

## ⚡ Quick Command Reference (Cheat Sheet)

### 1: Start & Setup
Start the cluster with the Docker driver (best for Kali Linux):
```bash
minikube start --driver=docker

### 2: Deploy & Verify
# Create the Deployment and Service
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Check status of Pods, Services, and Deployments
kubectl get all

##  Experiments Performed
#Self-Healing (Resurrection)

    Action: I manually deleted a Pod using Lens/CLI.

    Result: Kubernetes immediately detected the missing replica and spun up a new one to match the desired state.

## Scaling Test:
# Scaled the application from 3 to 10 replicas instantly to handle high traffic.

kubectl scale deployment my-web-deployment --replicas=10

## Zero-Downtime Rolling Update
#Switched the live web server from Nginx to Apache (httpd) without taking the site offline.

kubectl set image deployment/my-web-deployment nginx-container=httpd:latest
