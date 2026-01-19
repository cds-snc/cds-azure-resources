# Terraform module to create Conditional Access policies in Azure AD

# Conditional Access policies
resource "azuread_conditional_access_policy" "this" {
  display_name = var.policy_name
  state        = var.state

  conditions {
    client_app_types    = var.client_app_types
    user_risk_levels    = length(var.user_risk_levels) > 0 ? var.user_risk_levels : null
    sign_in_risk_levels = length(var.sign_in_risk_levels) > 0 ? var.sign_in_risk_levels : null

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

  dynamic "session_controls" {
    for_each = var.sign_in_frequency != null ? [var.sign_in_frequency] : []
    content {
      sign_in_frequency_authentication_type = session_controls.value.authentication_type
      sign_in_frequency_interval            = session_controls.value.frequency_interval
      sign_in_frequency                     = session_controls.value.value
      sign_in_frequency_period              = session_controls.value.type
    }
  }
}
