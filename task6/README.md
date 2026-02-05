# Week 6: Infrastructure as Code (Terraform & LocalStack)

##  Overview
In this task, I transitioned from manual cloud management to **Infrastructure as Code (IaC)**. I used **Terraform** to provision, manage, and destroy cloud resources automatically. To simulate a real cloud environment without costs, I used **LocalStack** (AWS emulator) running on Docker.

This project demonstrates the full Terraform lifecycle: **Write ➔ Plan ➔ Apply ➔ Modify ➔ Destroy**.

##  Tech Stack
* **IaC Tool:** Terraform
* **Cloud Emulator:** LocalStack (runs on Docker)
* **Cloud Provider:** AWS (Simulated)
* **OS:** Kali Linux
* **Scripting:** HCL (HashiCorp Configuration Language)

##  Project Files
* **`main.tf`**: The complete infrastructure definition.
    * **Provider:** Configured to talk to `localhost:4566` instead of real AWS.
    * **Resources:** VPC, Subnet, EC2 Instance, S3 Bucket.
    * **Outputs:** Automatically prints Server ID and IP address.

---

##  - Step-by-Step Guide

### 1 Setup & Installation
Before running the code, the environment was prepared:
```bash
# 1. Start LocalStack (The Fake Cloud)
docker run --rm -it -d -p 4566:4566 -p 4510-4559:4510-4559 --name localstack localstack/localstack

# 2. Configure AWS CLI (Mock Credentials)
aws configure
# Access Key: test | Secret Key: test | Region: us-east-1

# 2. Initialization
terraform init

# 3. Provisioning (Build)
terraform plan   # Preview changes
terraform apply  # Execute changes

# 4. Modification & Scaling (The "Upgrade")
Modified main.tf to perform real-world DevOps tasks:

    Added Storage: Created an S3 Bucket (aws_s3_bucket).

    Vertical Scaling: Upgraded the server from t2.micro to m5.large.

    Tagged: Renamed server to "Production-Server-v1".

# 5. Output Verification
terraform output
# Result:
# server_id = "i-xxxxxxxx"
# server_ip = "10.0.1.54"

# 6.Cleanup (Destroy)
terraform destroy
docker stop localstack

