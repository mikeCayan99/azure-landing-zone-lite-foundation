# Azure Landing Zone Lite Foundation

## Overview

This repository contains a lightweight Azure Landing Zone built with Terraform.

The project is designed as a learning and portfolio environment to demonstrate Infrastructure as Code (IaC), Azure networking, GitHub workflows, and cloud engineering best practices.

The goal is not to build a full enterprise-scale landing zone, but to create a modular and production-inspired foundation following modern cloud architecture principles.

---

## Architecture

The current architecture is based on a Hub-and-Spoke network topology.

```text
Resource Group
│
├── Hub Virtual Network
│   ├── Subnets
│   └── Network Security Groups
│
├── Spoke Workload Virtual Network
│   ├── Subnets
│   └── Network Security Groups
│
├── Spoke Shared Services Virtual Network
│   ├── Subnets
│   └── Network Security Groups
│
├── VNet Peerings
│   ├── Hub → Workload
│   ├── Workload → Hub
│   ├── Hub → Shared
│   └── Shared → Hub
│
└── Log Analytics Workspace
```

---

## Features

### Infrastructure

* Azure Resource Group
* Modular Virtual Network deployment
* Modular Subnet deployment
* Network Security Group deployment
* Subnet to NSG associations
* Hub-and-Spoke VNet peering
* Log Analytics Workspace

### Terraform

* Reusable Terraform modules
* Root and child module architecture
* Variables and outputs
* `for_each` based deployments
* Example configuration using `terraform.tfvars.example`

### DevOps

* GitHub Flow workflow
* Feature branches and Pull Requests
* GitHub Actions CI pipeline
* Automated Terraform checks

### CI/CD Pipeline

The GitHub Actions workflow performs:

* `terraform fmt`
* `terraform init`
* `terraform validate`
* `terraform plan`

Azure authentication is implemented using OpenID Connect (OIDC), eliminating the need for long-lived secrets.

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
│   └── log-analytics
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
└── terraform.tfvars.example
```

---

## Security

This project follows basic security best practices:

* No secrets stored in Git
* Local `terraform.tfvars` excluded via `.gitignore`
* Example configuration provided via `terraform.tfvars.example`
* GitHub OIDC authentication instead of client secrets

---

## Prerequisites

* Terraform
* Azure Subscription
* Azure CLI
* Git
* GitHub Account

---

## Getting Started

Clone the repository:

```bash
git clone https://github.com/<your-account>/azure-landing-zone-lite-foundation.git
```

Initialize Terraform:

```bash
terraform init
```

Create a local variables file:

```bash
copy terraform.tfvars.example terraform.tfvars
```

Review and adjust the values in `terraform.tfvars`.

Validate the configuration:

```bash
terraform validate
```

Create an execution plan:

```bash
terraform plan
```

---

## Current Status

Implemented:

* Resource Group
* Virtual Networks
* Subnets
* Network Security Groups
* Subnet Associations
* VNet Peering
* Log Analytics
* GitHub Actions CI
* Azure OIDC Authentication

---

## Roadmap

Planned improvements:

* Remote Terraform State
* Diagnostic Settings
* Azure Policy (light governance)
* RBAC examples
* Private DNS Zones
* Monitoring enhancements
* Architecture diagrams

---

## Learning Objectives

This repository focuses on learning and demonstrating:

* Azure networking fundamentals
* Infrastructure as Code with Terraform
* Modular Terraform design
* GitHub Actions
* CI/CD practices
* Cloud governance fundamentals
* Secure authentication with OIDC
