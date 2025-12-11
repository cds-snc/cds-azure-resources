# Terraform module to create Conditional Access policies in Azure AD

# Conditional Access policies
resource "azuread_conditional_access_policy" "this" {
  display_name = var.policy_name
  state        = var.state

  conditions {
    client_app_types = var.client_app_types

    users {
      included_users  = var.included_users
      included_groups = var.included_groups
      included_roles  = var.included_roles
      excluded_users  = var.excluded_users
      excluded_groups = var.excluded_groups
      excluded_roles  = var.excluded_roles
    }

    dynamic "applications" {
      for_each = var.included_applications != null ? [1] : []
      content {
        included_applications = var.included_applications
        excluded_applications = var.excluded_applications
      }
    }

    dynamic "locations" {
      for_each = var.included_locations != null ? [1] : []
      content {
        included_locations = var.included_locations
        excluded_locations = var.excluded_locations
      }
    }

    dynamic "platforms" {
      for_each = var.included_platforms != null ? [1] : []
      content {
        included_platforms = var.included_platforms
        excluded_platforms = var.excluded_platforms
      }
    }

    dynamic "devices" {
      for_each = var.device_filter != null ? [var.device_filter] : []
      content {
        filter {
          mode = devices.value.mode
          rule = devices.value.rule
        }
      }
    }
  }

  grant_controls {
    built_in_controls = var.built_in_controls
    operator          = var.operator
  }
}
