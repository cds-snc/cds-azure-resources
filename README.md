# CDS Azure Resources

## Overview
The CDS Azure Resources repository contains Terraform modules for managing cloud resources in Microsoft Azure. It is designed to help deploy and manage secure, scalable, and compliant cloud resources for CDS's (Canadian Digital Service) Azure environment.

## Features
- 🏗 **Infrastructure as Code (IaC)** using **Terraform**
- 🏢 **Management of Azure resources** via reusable modules
- 🛠 **Automated CI/CD pipelines** for validation and deployment

## Getting Started

### Prerequisites
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (>= v1.4.0)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Git](https://git-scm.com/downloads)
- Access to **Azure Subscription** with necessary permissions

### Clone the Repository
```sh
git clone https://github.com/cds-snc/cds-azure-resources.git
cd cds-azure-resources
```
### Configure Azure Authentication
Ensure you are authenticated to Azure before running Terraform:
```
az login
az account set --subscription <your-subscription-id>
```

### Deploy Infrastructure
Run the following Terraform commands:
```
terraform init      # Initialize the Terraform working directory
terraform plan      # Preview changes before applying
terraform apply     # Deploy resources to Azure
```
### Repository Structure
```
cds-azure-resources/
terragrunt/
│-- common /              # Common resources across all modules
│-- moudules/             # Reusable Terraform modules 
│-- *.tf    /             # Terraform files for resource definitions 
README.md             # Project documentation (this file)
```

## Contributing

Contributions are welcome! To contribute:

1. Fork this repository
2. Create a feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m "Add new feature"`)
4. Push to GitHub (`git push origin feature-name`)
5. Open a Pull Request and describe your changes

## CI/CD and Automation

- GitHub Actions are used to validate and deploy infrastructure changes.
- Pull Requests trigger Terraform plan checks to ensure no unintended changes are introduced.
- Changes are automatically deployed after approval and merge.

## Issues & Support
If you encounter any issues, please open a GitHub Issue.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Authors
Maintained by the Canadian Digital Service (CDS).

---