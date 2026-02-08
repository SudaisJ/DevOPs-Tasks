# Week 7: Configuration Management with Ansible

## Overview
In this task, I moved from "Infrastructure" to "Configuration." I used **Ansible** to automate the provisioning of a web server. Instead of manually installing packages and editing files, I wrote a **Playbook** that handles the entire lifecycle of the application.

## Tech Stack
* **Tool:** Ansible (Agentless automation)
* **Target:** Localhost (Simulating a remote web server)
* **OS:** Kali Linux
* **Modules Used:** `apt`, `service`, `git`, `template`

##  Project Files
* **`inventory.ini`**: Defines the target hosts (localhost).
* **`install_packages.yml`**: The main playbook (recipe) that:
    1. Updates the `apt` cache.
    2. Installs **Nginx** and **Git**.
    3. Starts the Nginx service.
    4. Deploys the **2048 Game** source code from GitHub.
    5. Configures a dynamic `index.html` using a **Jinja2 Template**.
* **`templates/index.html.j2`**: A dynamic HTML file that pulls variables (Hostname, OS Version) from the server automatically.

##  How to Run
1. **Install Ansible:**
   ```bash
   sudo apt install ansible sshpass

## 2. Run the Playbook:
ansible-playbook -i inventory.ini install_packages.yml --ask-become-pass

## 3. Verify Deployment:
Open http://localhost to see the dynamic welcome page.
Open http://localhost/game to play 2048.
