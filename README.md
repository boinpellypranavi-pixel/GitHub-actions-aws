GitHub Actions AWS Deployment
Overview

This repository demonstrates the deployment of a full-stack application to AWS using Terraform, Docker, and GitHub Actions. The application consists of:

Backend: A Node.js API built with Express.

Frontend: A React application served via Nginx.

The deployment leverages AWS services such as ECS, ECR, ALB, and CloudWatch for monitoring.

The infrastructure is provisioned using Terraform and includes:

ECS Cluster: Manages Docker containers.

ECR Repositories: Stores Docker images for backend and frontend.

Application Load Balancer (ALB): Routes traffic to the frontend and backend services.

CloudWatch: Monitors application performance and resource utilization.

Prerequisites

Ensure you have the following installed:

Terraform

Docker

AWS CLI

Node.js

GitHub CLI

Setup
Clone the Repository
git clone https://github.com/boinpellypranavi-pixel/GitHub-actions-aws.git
cd GitHub-actions-aws

Configure AWS Credentials

Set up your AWS credentials using the AWS CLI:

aws configure


Alternatively, configure GitHub Actions secrets for CI/CD:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

Initialize Terraform
cd infrastructure
terraform init

Deployment
Build and Push Docker Images
# Backend
docker build -t backend ./backend
aws ecr get-login-password --region ca-central-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com
docker tag backend:latest <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com/backend:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com/backend:latest

# Frontend
docker build -t frontend ./frontend
docker tag frontend:latest <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com/frontend:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com/frontend:latest

Apply Terraform Configuration
terraform apply -auto-approve

CI/CD Pipeline

The GitHub Actions workflow automates the deployment process:

Trigger: On push to the main branch.

Steps:

Set up AWS credentials.

Build and push Docker images to ECR.

Deploy infrastructure using Terraform.

Workflow file: .github/workflows/deploy.yml

Monitoring and Logging

CloudWatch Logs: Logs are generated for both backend and frontend services.

CloudWatch Alarms: Set up to monitor CPU and memory usage, with notifications configured.

Security

HTTPS: The Application Load Balancer is configured with SSL certificates to serve traffic over HTTPS.

Basic Authentication: Implemented for the backend API to restrict access.

Clean Up

To destroy the infrastructure:

terraform destroy -auto-approve

License

This project is licensed under the MIT License.

References

AWS ECS Documentation

Terraform AWS Provider

GitHub Actions Documentation
