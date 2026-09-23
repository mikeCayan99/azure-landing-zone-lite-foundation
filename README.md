# Azure Landing Zone Lite Foundation

A modular Azure Landing Zone foundation built with Terraform and GitHub Actions.

The architecture combines Hub-and-Spoke networking, governance, observability, role-based access control, remote state preparation, and secure CI authentication using Azure OpenID Connect (OIDC).

---

## Architecture

```mermaid
flowchart TB
    GH["GitHub Repository"]
    GHA["GitHub Actions"]
    OIDC["Azure OIDC Authentication"]
    TF["Terraform"]

    RG["Azure Resource Group"]

    HUB["Hub VNet"]
    SPOKE1["Workload Spoke VNet"]
    SPOKE2["Shared Services Spoke VNet"]

    NSG["Network Security Groups"]

    LAW["Log Analytics Workspace"]
    DIAG["Diagnostic Settings"]

    POLICY["Azure Policy<br/>Allowed Locations"]
    RBAC["Azure RBAC<br/>Reader Role"]

    STORAGE["Storage Account"]

    GH --> GHA
    GHA --> OIDC
    OIDC --> TF
    TF --> RG

    RG --> HUB
    RG --> SPOKE1
    RG --> SPOKE2

    HUB <-->|VNet Peering| SPOKE1
    HUB <-->|VNet Peering| SPOKE2

    SPOKE1 --> NSG
    SPOKE2 --> NSG

    RG --> LAW
    STORAGE --> DIAG
    DIAG --> LAW

    RG --> POLICY
    RG --> RBAC

    RG --> STORAGE
```

The platform follows a lightweight Hub-and-Spoke architecture with centralized infrastructure components and isolated workload networks.

---

## Infrastructure Components

The foundation includes:

* Azure Resource Group
* Hub Virtual Network
* Workload Spoke Virtual Network
* Shared Services Spoke Virtual Network
* Multiple Azure Subnets
* Network Security Groups
* Subnet-to-NSG Associations
* VNet Peering
* Log Analytics Workspace
* Diagnostic Settings
* Azure Policy Assignment
* Azure RBAC Role Assignment
* Azure Storage Account
* Terraform Remote State Bootstrap
* GitHub Actions CI
* Azure OpenID Connect Authentication

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│
├── bootstrap/
│   └── tfstate/
│
├── modules/
│   ├── diagnostic-setting/
│   ├── log-analytics/
│   ├── network-security-group/
│   ├── policy-assignment/
│   ├── role-assignment/
│   ├── storage-account/
│   ├── subnet/
│   ├── subnet-nsg-association/
│   ├── virtual-network/
│   └── vnet-peering/
│
├── backend.tf.example
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
├── versions.tf
├── terraform.tfvars.example
└── README.md
```

Infrastructure components are separated into reusable Terraform modules and orchestrated through the root module using explicit inputs and outputs.

---

## Networking

The network architecture follows a Hub-and-Spoke model.

```text
                     Hub VNet
                    /        \
                   /          \
            Peering            Peering
               /                  \
              ↓                    ↓
     Workload Spoke        Shared Services Spoke
        │     │                     │
        │     │                     │
       App   Data              Shared Services
      Subnet Subnet                Subnet
```

The Hub provides the central network foundation while dedicated Spoke VNets separate workload and shared-service environments.

Network Security Groups are associated with individual subnets through reusable Terraform modules.

The architecture can be extended with additional platform services such as Private Endpoints, Private DNS, Azure Firewall, Bastion, or hybrid connectivity.

---

## Governance

Azure Policy provides governance controls for the Landing Zone.

The current configuration includes an Allowed Locations policy assignment to control the Azure regions in which resources can be deployed.

```text
Azure Resource Group
        ↓
Azure Policy Assignment
        ↓
Allowed Locations
        ↓
Deployment Governance
```

The modular implementation allows additional governance policies to be introduced without restructuring the core infrastructure.

---

## Security

### Azure RBAC

Role-Based Access Control is implemented through a reusable Terraform role-assignment module.

The configuration separates the three primary authorization properties:

```text
Principal
+
Role
+
Scope
```

The current implementation includes a Reader role assignment at Resource Group scope.

### OpenID Connect

GitHub Actions authenticates with Azure using OpenID Connect.

```text
GitHub Actions
      ↓
OIDC Token
      ↓
Microsoft Entra ID
      ↓
Azure
```

OIDC removes the requirement to store long-lived Azure client secrets in GitHub.

No passwords, API keys, access keys, or cloud credentials are intentionally stored in the repository.

---

## Observability

### Log Analytics

A Log Analytics Workspace provides the central foundation for Azure telemetry and monitoring.

### Diagnostic Settings

Diagnostic Settings forward supported Azure resource telemetry to the central Log Analytics Workspace.

```text
Azure Resource
      ↓
Diagnostic Settings
      ↓
Log Analytics Workspace
```

The monitoring architecture can be extended with alerts, additional diagnostic categories, dashboards, and security monitoring.

---

## Terraform Remote State

A dedicated bootstrap configuration is located under:

```text
bootstrap/tfstate
```

It prepares the Azure infrastructure required for Terraform remote state:

```text
Bootstrap Terraform
        ↓
Resource Group
        ↓
Storage Account
        ↓
Blob Container
        ↓
Terraform Remote State
```

The repository also provides:

```text
backend.tf.example
```

After provisioning the backend infrastructure, the configuration can be used as the basis for enabling the Azure Storage backend.

State migration can then be performed with:

```bash
terraform init -migrate-state
```

Terraform state files are excluded from Git.

---

## Continuous Integration

GitHub Actions validates Terraform infrastructure changes before they are merged into `main`.

```text
Feature Branch
      ↓
Pull Request
      ↓
GitHub Actions
      ↓
Azure OIDC Authentication
      ↓
Terraform Init
      ↓
Terraform Format Check
      ↓
Terraform Validate
      ↓
Terraform Plan
      ↓
Merge
```

The pipeline provides automated validation while Azure authentication is handled through short-lived OIDC credentials.

---

## Git Workflow

Infrastructure changes follow a branch-based development workflow:

```text
main
  ↓
feature/*
  ↓
Infrastructure Change
  ↓
terraform fmt
  ↓
terraform validate
  ↓
terraform plan
  ↓
Commit
  ↓
Push
  ↓
Pull Request
  ↓
GitHub Actions
  ↓
Merge
```

This keeps the `main` branch stable while maintaining a traceable history of infrastructure changes.

---

## Deployment Approach

Infrastructure changes are validated through Terraform and GitHub Actions before deployment.

Typical commands include:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Deployment remains an explicit operation:

```bash
terraform apply
```

Resources can be removed when no longer required:

```bash
terraform destroy
```

This approach separates infrastructure validation from deployment and prevents unintended resource creation.

---

## Cost Controls

The architecture is designed with Azure cost awareness in mind.

Current design decisions include:

* Explicit rather than automatic infrastructure deployment
* Terraform plan validation through CI
* Dedicated remote-state bootstrap configuration
* Modular architecture that allows optional services to be introduced independently
* Cost-intensive networking services excluded from the default configuration

Services such as Azure Firewall, Bastion, VPN Gateway, DDoS Protection, and Microsoft Defender for Cloud can be introduced as architecture extensions when required.

---

## Technologies

* Microsoft Azure
* Terraform
* Git
* GitHub
* GitHub Actions
* Microsoft Entra ID
* OpenID Connect
* Azure Virtual Network
* Azure Network Security Groups
* Azure RBAC
* Azure Policy
* Azure Monitor
* Log Analytics
* Azure Storage

---

## Architecture Extensions

The modular foundation supports further platform capabilities such as:

* Managed Identities
* Azure Key Vault
* Private Endpoints
* Private DNS Zones
* Additional Azure Policies
* Extended RBAC configurations
* Monitoring alerts
* Additional Diagnostic Settings
* Environment-specific configurations
* Remote State integration
* Additional security hardening

---

## Security Notice

Terraform state files, credentials, passwords, access keys, and other sensitive configuration must not be committed to this repository.

Authentication from GitHub Actions to Azure is implemented using OpenID Connect to avoid long-lived cloud credentials.
