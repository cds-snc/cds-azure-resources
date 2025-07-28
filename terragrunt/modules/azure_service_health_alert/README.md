# Azure Service Health Alert Module

This module creates an Azure Service Health alert with an action group that sends notifications to specified email addresses when Azure service health events occur.

## Features

- Creates an action group with email notifications for SRE/Tech Ops and Security teams
- Sets up a service health activity log alert for the specified subscription
- Configurable service health event types, locations, and services to monitor
- Uses common alert schema for better notification formatting

## Usage

```hcl
module "service_health_alert" {
  source = "./modules/azure_service_health_alert"

  subscription_id     = "f27b081a-aa54-4ab4-9f26-a4c5375dc8fa"
  resource_group_name = "pubsec-service-health"
  
  alert_name        = "ALZ Service Health Alert"
  alert_description = "Alert rule for Azure Landing Zone Service Health"
  
  # Optional: Override default email addresses
  sre_email      = "sre-and-tech-ops@cds-snc.ca"
  security_email = "security@cds-snc.ca"
  
  # Optional: Customize monitored events and locations
  service_health_events = ["Incident", "Security", "Maintenance"]
  service_health_locations = ["Canada Central", "Canada East", "Global"]
  
  tags = {
    ClientOrganization = "cds-snc"
    CostCenter         = "sentinel"
    DataSensitivity    = "U"
    ProjectContact     = "Security@CDS"
    ProjectName        = "Sentinel"
    TechnicalContact   = "security@cds-snc.ca"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| azurerm | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_monitor_action_group.service_health | resource |
| azurerm_monitor_activity_log_alert.service_health | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subscription_id | The subscription ID to create the service health alert for | `string` | n/a | yes |
| resource_group_name | The name of the resource group where the resources will be created | `string` | n/a | yes |
| location | The Azure region where the resource group is located | `string` | `"canadacentral"` | no |
| alert_name | The name of the service health alert | `string` | `"Service Health Alert"` | no |
| alert_description | Description for the service health alert | `string` | `"Alert rule for Azure Service Health events"` | no |
| action_group_name | The name of the action group | `string` | `"Service Health Action Group"` | no |
| action_group_short_name | The short name of the action group (max 12 characters) | `string` | `"SvcHealthAG"` | no |
| sre_email | SRE and Tech Ops email address | `string` | `"sre-and-tech-ops@cds-snc.ca"` | no |
| security_email | Security team email address | `string` | `"security@cds-snc.ca"` | no |
| service_health_events | List of service health event types to monitor | `list(string)` | `["Incident", "Security", "Maintenance", "Information", "ActionRequired"]` | no |
| service_health_locations | List of Azure regions to monitor for service health events | `list(string)` | `["Canada Central", "Canada East", "Global"]` | no |
| service_health_services | List of Azure services to monitor. Empty list means all services | `list(string)` | `[]` | no |
| enabled | Whether the alert rule is enabled | `bool` | `true` | no |
| tags | A mapping of tags to assign to the resources | `map(string)` | See variables.tf | no |

## Outputs

| Name | Description |
|------|-------------|
| action_group_id | The ID of the action group |
| action_group_name | The name of the action group |
| activity_log_alert_id | The ID of the service health activity log alert |
| activity_log_alert_name | The name of the service health activity log alert |

## Service Health Event Types

The module supports monitoring the following service health event types:

- **Incident**: Service issues affecting Azure services
- **Security**: Security-related advisories and incidents
- **Maintenance**: Planned maintenance activities
- **Information**: General informational updates
- **ActionRequired**: Events requiring user action

## Notes

- The action group is created with `location = "global"` as it's a global resource
- The activity log alert is scoped to the entire subscription
- Email receivers use the common alert schema for better formatting
- The module includes default tags following CDS-SNC conventions
