Cloud Infrastructure & Automated Deployment Documentation (Task 12)
1. Executive Summary

This document details the automated provisioning and deployment pipeline for the OpsForge production environment on Amazon Web Services (AWS). Utilizing an Infrastructure as Code (IaC) model via Terraform, the architecture establishes a dedicated Virtual Private Cloud (VPC), configures granular network access lists, spins up an elastic compute platform, and bootstraps a containerized runtime environment completely independent of manual intervention.
2. Architectural Blueprint

[ Global Internet ] 
        │
        ▼ (Routs via DNS A-Record: opsforge.hopto.org)
[ Public IP: 32.199.138.29 ]
        │
        ▼
[ Internet Gateway (IGW) ]
        │
        ▼
[ Route Table: 0.0.0.0/0 ]
        │
        ▼
[ Security Group Firewall ] ──► Blocks: All Unspecified Traffic
        │                   ──► Allows: Port 22 (SSH), Port 80 (HTTP)
        ▼
[ Public Subnet: 10.0.1.0/24 ]
        │
        ▼
[ EC2 Instance: t3.micro (Ubuntu 24.04) ]
        │
        ▼ (Automated cloud-init Bootstrapping)
   [ Docker Daemon Engine ]
        │
        ▼
   [ Container: Nginx Web Server (Port 80:80) ]

3. Component Breakdown
A. Networking & Core Infrastructure

    Virtual Private Cloud (VPC): Provisioned with a dedicated CIDR block (10.0.0.0/16) to isolate corporate microservices from adjacent public cloud networks.

    Public Subnet: Formatted with a targeted subnet slice (10.0.1.0/24) explicitly inside the us-east-1a availability zone. map_public_ip_on_launch is enabled to facilitate external public availability.

    Internet Gateway (IGW) & Route Tables: A custom gateway establishes a binding path between the VPC and the public internet, governed by an automated route table entry directing all outbound traffic (0.0.0.0/0) dynamically through the edge interface.

B. Security Layer

    Stateful Security Group: Acts as a network-level firewall.

        Inbound (Ingress): Strict pinholing limited to port 22 (Secure Shell management access) and port 80 (Standard HTTP frontend application delivery).

        Outbound (Egress): Allows unrestricted egress (-1 protocols across all ports) to ensure systemic software layers can securely pull external patches and container dependencies.

    Asymmetric Key Pair: Injected an external public SSH key (opsforge_key.pub) straight into the hardware abstraction layer of the instance during provisioning, safeguarding remote execution capabilities.

C. Compute & Automated Configuration Engine

    Compute Tier: Provisions an AWS EC2 instance running on a resource-efficient t3.micro instance pool utilizing the standard Ubuntu x86 hardware layout.

    Cloud-Init Bootstrapping Script (user_data): Capitalizes on zero-indent left-flush execution blocks to force immediate local configuration on launch. The engine executes sequentially:

        System inventory upgrade (apt-get update)

        Native virtualization engine installation (docker.io)

        Runtime initialization and boot persistence configuration (systemctl start/enable docker)

        Immediate stateless retrieval and execution of the lightweight core service tier container on target web hooks (docker run -d -p 80:80 nginx:latest).

D. DNS & Edge Routing Translation

    Dynamic DNS Provider: Managed using a third-party global authoritative dynamic DNS routing registrar.

    A-Record Pointer: Registers the explicit subdomain opsforge.hopto.org targeting the external runtime elastic IPv4 allocation (32.199.138.29), bypassing raw IP addressing paradigms for production-level interface validation.

4. Verification & Status Metrics

The platform infrastructure has been successfully validated from the administrative terminal utilizing targeted packet analysis.

    DNS Name Space Resolution: Verified via local terminal domain query pipelines:
    Bash

$ ping -c 4 opsforge.hopto.org
PING opsforge.hopto.org (32.199.138.29) 56(84) bytes of data.

Result: Name resolution functions optimally; the global registry cleanly binds the textual domain directly to the live cloud system.

Application Delivery Validation: Confirmed using verbose header diagnostic evaluations:
Bash

    $ curl -v http://32.199.138.29
    < HTTP/1.1 200 OK
    < Server: nginx/1.31.2

    Result: The backend engine answers requests instantly with a 200 OK connection header, proving successful configuration lifecycle orchestration.

5. Security & Architectural Recommendations (Future Iterations)

    Restrict SSH Ingress Scope: Modify the ingress configuration blocks within main.tf to restrict port 22 access strictly to the administrator's specific local public IP address instead of using open internet vectors (0.0.0.0/0).

    Implement Private Subnet Architecture: Migrate the main system tier out of the public subnet block. Introduce an AWS Application Load Balancer (ALB) at the public perimeter layer and sink the compute resources securely into a non-routable back-end subnet block (10.0.2.0/24) to minimize direct external exposure.
