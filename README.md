CloudNet Infrastructure Platform
--------------------------------------------------------------------------------------------------------------------------------------------
Overview

CloudNet is a Terraform-based AWS infrastructure platform designed to provision and manage a scalable cloud-native application environment.

The project is split into two independent Terraform stacks:
Stack                  Purpose
--------------------------------------------------------------------------------------------------------------------------------------------
Harshal-stack-1     	Creates S3 infrastructure and Terraform remote state dependencies
Harshal-stack-2	      Deploys the primary application infrastructure platform on AWS

The platform provisions:
--------------------------------------------------------------------------------------------------------------------------------------------
AWS networking infrastructure
Auto Scaling compute layer
Internal and external load balancing
MySQL RDS database
CloudFront CDN
Monitoring and alerting
Slack notification delivery
Terraform remote state architecture

Architecture Overview
----------------------------------------------------------------------------------------------------------------------------------------------
              


         
Repository Structure
----------------------------------------------------------------------------------------------------------------------------------------------
cloudnet/
├── Harshal-stack-1/
│├── provider.tf
│   ├── main.tf
│   ├── variable.tf
│   ├── env/
│   └── locaclmodul/
│       └── s3/
│
├── Harshal-stack-2/
│   ├── provider.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── nlb.tf
│   ├── asg.tf
│   ├── rds.tf
│   ├── cloudfront.tf
│   ├── cloudwatch.tf
│   ├── sns.tf
│   ├── lambda.tf
│   ├── envirolment/
│   └── localmodules/
│
└── README.md

Stack 1 — S3 Remote State Infrastructure
-----------------------------------------------------------------------------------------------------------------------------------------------
Purpose

Harshal-stack-1 provisions the foundational S3 infrastructure required for:

- Application artifact storage
- Terraform remote state management
- Cross-stack dependency sharing

This stack must be deployed before Stack 2.

------------------------------------------------------------------------------------------------------------------------------------------------
Components
AWS Provider

Configured with:

AWS Region: us-east-1
Terraform Version: 1.13.4
AWS Provider Version: 6.35.1

Terraform Backend
------------------------------------------------------------------------------------------------------------------------------------------------
Uses S3 backend:

backend "s3" {
  key = "envs/dev/app/terraform.tfstate"
}

Locla S3 module
------------------------------------------------------------------------------------------------------------------------------------------------
location:
   localmodule/s3/

Responsibilities:
- Create S3 bucket resources
- Expose outputs for dounstream stack
- Support terraform remote state access

------------------------------------------------------------------------------------------------------------------------------------------------
Stack 2 -- AWS Application Infrastucture
Purpose
Harshal-stack-2 provisions the primary application platform infrastucture on AWS.
It includes:

- Networking
- Compute
- Database
- Load balancing
- CDN
- Monitoring
- Notifications
------------------------------------------------------------------------------------------------------------------------------------------------
Infrastructure Architecture
Networking Layer
Module: networking
Creates:
- VPC
- Public subnets
- private subnets
- Internet Gateway
- NAT Gateway
- Route tables

Load Balancing Layer
------------------------------------------------------------------------------------------------------------------------------------------------
Module: loadbalancing
Creates:

External ALB
Handles:
- HTTP traffic
- Frontend routing
- CloudFront origin traffic

Internal NLB
Handles:
- Backend TCP traffic
- internal service routing

Target Groups
Target Group                Protocol                 Port
------------------------------------------------------------------------------------------------------------------------------------------------
Backend                     TCP                      8084
Frontend                    HTTP                     8501

------------------------------------------------------------------------------------------------------------------------------------------------
Compute Layer
Module: autoscaling
Creates:
- Launch Templates
- IAM roles
- EC2 Auto scaling group
- CloudWatch Agent setup
- Application runtime provisioning

------------------------------------------------------------------------------------------------------------------------------------------------
Runtime Bootstrapping
EC2 User data performs:
1. Install java 11 Corretto
2. Download JAR from S3
3. Configure environment variables
4. Start Spring Boot application
5. Configure Cloudwatch logs

------------------------------------------------------------------------------------------------------------------------------------------------
Auto Scaling Configuration
Variable                               Purpose
------------------------------------------------------------------------------------------------------------------------------------------------
