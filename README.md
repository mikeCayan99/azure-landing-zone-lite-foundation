# Azure Landing Zone Lite Foundation

## Overview

This repository contains a lightweight Azure Landing Zone built with Terraform.

The project serves as a learning and portfolio environment to demonstrate Infrastructure as Code (IaC), Azure networking, GitHub Actions, and cloud engineering best practices.

The goal is to build a modular and production-inspired Azure foundation while following modern cloud architecture principles.

---

## Architecture

Current architecture:

```text
Resource Group
│
├── Hub Virtual Network
│   └── Shared Services Subnet
│
├── Spoke Workload Virtual Network
│   ├── App Subnet
│   └── Data Subnet
│
├── Spoke Shared Services Virtual Network
│   └── Shared Services Subnet
│
├── Network Security Groups
│
├── Subnet ↔ NSG Associations
│
├── VNet Peerings
│
├── Log Analytics Workspace
│
└── Storage Account (Remote State Preparation)
```

---

## Features

### Networking

- Hub-and-Spoke architecture
- Virtual Networks
- Subnets
- Network Security Groups
- Subnet to NSG Associations
- VNet Peering

### Monitoring

- Log Analytics Workspace

### Storage

- Storage Account module
- Blob Container for future Terraform remote state

### Terraform

- Reusable Terraform modules
- Root and child module architecture
- Variables and outputs
- `for_each` based deployments

### DevOps

- GitHub Flow
- Pull Requests
- Feature Branches
- GitHub Actions CI Pipeline

---

## CI/CD Pipeline

The GitHub Actions workflow automatically performs:

- Terraform Format Check
- Terraform Init
- Terraform Validate
- Terraform Plan

Azure authentication is implemented using OpenID Connect (OIDC), eliminating the need for long-lived credentials or secrets.

---

## Repository Structure

```text
.
├── .github/workflows
├── modules
│   ├── virtual-network
│   ├── subnet
│   ├── network-security-group
│   ├── subnet-nsg-association
│   ├── vnet-peering
│   ├── log-analytics
│   └── storage-account
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
└── terraform.tfvars.example
```

---

## Security

Security best practices implemented:

- No secrets stored in Git
- Local `terraform.tfvars` excluded via `.gitignore`
- OIDC authentication for GitHub Actions
- GitHub repository variables for Azure authentication

---

## Prerequisites

- Terraform
- Azure CLI
- Azure Subscription
- Git
- GitHub Account

---

## Getting Started

Clone the repository:

```bash
git clone https://github.com/mikeCayan99/azure-landing-zone-lite-foundation-.git
```

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Generate an execution plan:

```bash
terraform plan
```

---

## Current Status

Implemented:

- Resource Group
- Virtual Networks
- Subnets
- Network Security Groups
- Subnet Associations
- VNet Peering
- Log Analytics Workspace
- Storage Account Module
- GitHub Actions CI
- Azure OIDC Authentication

---

## Roadmap

Planned improvements:

- Remote Terraform State
- Azure Policy (Light Governance)
- Diagnostic Settings
- RBAC Examples
- Architecture Diagram

---

## Learning Objectives

This project focuses on learning and demonstrating:

- Azure networking fundamentals
- Infrastructure as Code with Terraform
- Modular Terraform design
- GitHub Actions
- CI/CD practices
- Cloud governance fundamentals
- Secure authentication with OIDC