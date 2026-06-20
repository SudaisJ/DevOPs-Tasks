# - Week 10: Full GitOps CI/CD Pipeline

## 🎯 Project Goal
To build a fully automated GitOps pipeline that continuously integrates code changes, builds containerized applications, and deploys them to a local Kubernetes cluster without manual intervention.

## 🛠️ Technology Stack
* **VCS:** GitHub
* **CI/CD Automation:** Jenkins (Dockerized)
* **Containerization:** Docker & Docker Hub
* **Orchestration:** Kubernetes (Minikube)
* **Web Server:** Nginx (Alpine)

## 🏗️ Pipeline Architecture
The Jenkins declarative pipeline (`Jenkinsfile`) monitors this repository and executes four automated stages upon every new commit:

1. **Clone Repository:** Pulls the latest source code from the `main` branch.
2. **Build Docker Image:** Packages the HTML application into a lightweight Nginx container (`sudaisj/task10-app`).
3. **Push to Docker Hub:** Authenticates and securely pushes the newly tagged image to the public container registry.
4. **Deploy to Kubernetes:** Updates the `deployment.yaml` with the new build tag and applies the configuration (along with a NodePort service) directly to the Minikube cluster using a portable `kubeconfig`.

## ⚙️ Automation Trigger
* **SCM Polling:** Jenkins is configured to poll the GitHub repository every minute (`* * * * *`). 
* **Zero-Touch Deployment:** Pushing code to the `main` branch automatically triggers the entire build, test, and deployment lifecycle.

## 📂 Repository Structure
```text
.
├── app/
│   ├── index.html       # Web application source code
│   └── Dockerfile       # Container build instructions
└── k8s/
    ├── deployment.yaml  # K8s ReplicaSet and Pod configuration
    └── service.yaml     # K8s NodePort service for external access
