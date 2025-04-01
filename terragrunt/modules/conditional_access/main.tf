# Terraform module to create Conditional Access policies in Azure AD

# Conditional Access policies
resource "azuread_conditional_access_policy" "this" {
  display_name = var.policy_name
  state        = "enabled"

  conditions {
    client_app_types = var.client_app_types

    applications {
      included_applications = var.included_applications
      excluded_applications = var.excluded_applications
    }

    locations {
      included_locations = var.included_locations
      excluded_locations = var.excluded_locations
    }

    platforms {
      included_platforms = var.included_platforms
      excluded_platforms = var.excluded_platforms
    }

    users {
      included_users  = var.included_users
      excluded_groups = var.excluded_groups
    }
  }

  grant_controls {
    built_in_controls = var.built_in_controls
    operator          = var.operator
  }
}
