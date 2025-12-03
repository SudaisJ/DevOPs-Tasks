 Overview

For Day 3 of my DevOps journey, I built a Continuous Integration (CI) pipeline using GitHub Actions. The goal was to automate the testing and building process of a Python application whenever new code is pushed to the repository.

This project demonstrates how to automatically build a Docker image and run unit tests to ensure code quality before deployment.

 Key Features

Automated Workflow: Triggers automatically on every push to the main branch.

Unit Testing: Runs pytest to verify the application logic.

Docker Integration: Builds a lightweight Docker image for the application.

Security: Uses GitHub Secrets (DOCKER_USERNAME, DOCKER_PASSWORD) to securely handle credentials.

Environment Management: Sets up a Python environment and installs dependencies dynamically.

📂 Project Structure

day_3/
├── .github/workflows/
│   └── ci.yml          # The CI pipeline configuration (YAML)
├── app.py              # The main Python application
├── test_app.py         # Unit tests for the application
├── Dockerfile          # Instructions to containerize the app
├── requirements.txt    # Python dependencies
└── README.md           # This documentation


🛠️ The CI Pipeline (ci.yml)

The workflow performs the following steps sequentially:

Checkout Code: Pulls the latest code from the repository.

Set Environment: Defines global variables (e.g., ENV=production).

Setup Python: Installs Python 3.10.

Install Dependencies: Installs libraries from requirements.txt.

Run Tests: Executes pytest. If tests fail, the pipeline stops.

Build Docker Image: Creates a Docker image tagged day3-app:latest.

Login to Docker Hub: Authenticates securely using GitHub Secrets.

How to Run This Project

1. Prerequisites

A GitHub account.

A Docker Hub account.

2. Setup Secrets

To enable the Docker login step, add these secrets in your GitHub Repository settings (Settings -> Secrets and variables -> Actions):

DOCKERUSERNAME: Your Docker Hub username.

DOCKERPASSWORD: Your Docker Hub password (or access token).

3. Trigger the Pipeline

Simply push a change to the main branch:

git add .
git commit -m "Update application logic"
git push origin main


Go to the Actions tab in your GitHub repository to watch the pipeline run in real-time!

 Local Testing

You can also run the app and tests locally:

# Run tests
pytest

# Build Docker image locally
docker build -t day3-app .

# Run the container
docker run day3-app

