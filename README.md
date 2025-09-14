# Logo Server

A simple Express.js web server that serves the Swayatt logo image.

## What is this app?

This is a lightweight Node.js application built with Express.js that serves a single logo image (`logoswayatt.png`) when accessed through a web browser. When you visit the root URL, the server responds by displaying the Swayatt logo.

## Prerequisites

- Node.js (version 12 or higher)
- npm (Node Package Manager)

## Installation

1. Clone or download this repository
2. Navigate to the project directory:
   ```bash
   cd "devops task"
How to Start the App

Run the following command:

npm start


The server will start and display:

Server running on http:54.91.162.247//:30152

Usage

Once the server is running, open your web browser and navigate to:

http:54.91.162.247//:30152


Project Structure
├── app.js              # Main server file
├── package.json        # Project dependencies and scripts
├── logoswayatt.png     # Logo image file
└── README.md           # This file

Technical Details

Framework: Express.js

Port: 30152

Endpoint: GET / - serves the logo image

File served: logoswayatt.png

DevOps Task: CI/CD on EKS with Monitoring
📌 Architecture Diagram
flowchart LR
    Dev[Developer] --> GitHub
    GitHub --> Jenkins
    Jenkins -->|Build & Deploy| EKS
    EKS --> Pods[Application Pods]
    EKS --> awsAuth[aws-auth ConfigMap]
    EKS --> FluentBit[Fluent Bit DaemonSet]
    FluentBit --> CloudWatch

⚙️ Setup Instructions
1. ### Infrastructure Provisioning (Terraform)

The complete infrastructure (VPC, subnets, EKS cluster, node groups, IAM roles) is provisioned using Terraform.

After applying Terraform, an EKS cluster named my-eks-cluster is created and ready for deployments.

2. ### Jenkins Pipeline Configuration

The Jenkins pipeline automates the full CI/CD workflow with the following stages:

Build – Installs dependencies and builds the Node.js application.

SonarCloud Analysis – Runs static code analysis and pushes results to SonarCloud for code quality and vulnerability checks.

Dockerize – Builds a Docker image for the application using the provided Dockerfile.

Push to Amazon ECR – Pushes the Docker image to a private Amazon Elastic Container Registry (ECR) repository.

Deploy to EKS – Applies Kubernetes manifests (deployment.yaml, svc.yaml, aws-auth.yaml) to deploy the application into the EKS cluster.

3### Kubernetes Access Control

An aws-auth.yaml ConfigMap is configured to map the Jenkins IAM user (jenkins-user) to Kubernetes RBAC.

This grants the Jenkins pipeline system:masters permissions, enabling it to run kubectl commands directly against the EKS cluster during deployments.

4. ### Logging & Monitoring

Installed Fluent Bit DaemonSet on the EKS cluster to forward container logs to Amazon CloudWatch Logs.

Logs are available in the following CloudWatch log groups:

/aws/containerinsights/my-eks-cluster/application → Application logs

/aws/containerinsights/my-eks-cluster/dataplane → Kubernetes system logs

🛠️ Tools & Services Used

Terraform – Infrastructure provisioning (VPC, EKS, IAM, subnets, node groups).

Jenkins – CI/CD pipeline automation.

SonarCloud – Static code analysis and code quality checks.

Docker – Containerization of the Node.js application.

Amazon ECR – Private registry for storing Docker images.

Amazon EKS (Kubernetes) – Hosting and orchestrating application workloads.

Fluent Bit + CloudWatch – Centralized logging and monitoring.

GitHub – Source code repository.

⚡ Challenges Faced & Solutions

### IAM Authentication with EKS

Challenge: Jenkins user didn’t have access to run kubectl commands.

Solution: Configured aws-auth ConfigMap to map jenkins-user IAM role to Kubernetes system:masters.

### Jenkins Pipeline Stuck due to Low Disk Space 
 During pipeline execution, the Jenkins jobs were frequently getting stuck because the disk space on the Jenkins server was running low. To troubleshoot, I used commands like top to check resource usage and df -h to identify disk consumption. After identifying the issue, I increased the disk size, which resolved the problem and allowed the pipelines to run smoothly.

🚀 Possible Improvements if Given More Time

External Access via ALB + Route 53 – Configure AWS ALB Ingress Controller and Route 53 DNS mapping for secure, scalable external access to the application.

End-to-End Observability – Instead of relying only on CloudWatch log groups, implement a full observability stack:

Prometheus & Grafana – Metrics collection and real-time visualization.

ELK Stack (Elasticsearch, Logstash, Kibana) – Centralized log aggregation and advanced search.

Jaeger – Distributed tracing to track request flows across microservices.

Security & Vulnerability Scanning – Implement Snyk to detect vulnerabilities in dependencies and container images, and integrate OWASP ZAP scans covering the top 5 principles (Injection, Broken Authentication, Sensitive Data Exposure, XML External Entities, Security Misconfiguration).