# Create the named locations and conditional access policies in the Azure AD tenant

# Create named locations for US, Canada and ESDC Ips
resource "azuread_named_location" "canada" {
  display_name = "Canada"
  country {
    countries_and_regions = [
      "CA",
    ]
    include_unknown_countries_and_regions = false
  }
}

resource "azuread_named_location" "united_states" {
  display_name = "United States"
  country {
    countries_and_regions = [
      "US",
    ]
    include_unknown_countries_and_regions = false
  }
}

resource "azuread_named_location" "esdc_ips" {
  display_name = "ESDC IPs"
  ip {
    ip_ranges = [
      "198.103.0.0/16",
    ]
    trusted = true
  }
}

# Conditional access policy to block non-browser access
module "block_non_browser" {
  source                = "./modules/conditional_access"
  policy_name           = "Conditional Access - Block Non-Browser Access"
  client_app_types      = ["exchangeActiveSync", "mobileAppsAndDesktopClients", "other"]
  included_applications = ["All"]
  excluded_applications = ["797f4846-ba00-4fd7-ba43-dac1f8f63013"] # this is the resource id of Azure CLI, application ID doesn't work
  included_locations    = ["All"]
  included_platforms    = ["all"]
  included_users        = ["All"]
  excluded_groups       = ["86a827be-9f2d-46fe-992e-9445ec10e840", "9c8babe3-fe86-42b1-ace6-16734f559c60", "dda4f58f-e024-40da-9403-761270c5cc47"]
  built_in_controls     = ["block"]
  operator              = "OR"
}

# Conditional access policy to block access from outside of Canada
module "block_out_of_canada" {
  source                = "./modules/conditional_access"
  policy_name           = "Conditional Access - Block Out of Canada"
  client_app_types      = ["all"]
  included_applications = ["All"]
  included_locations    = ["All"]
  excluded_locations    = [resource.azuread_named_location.united_states.id, resource.azuread_named_location.canada.id]
  included_platforms    = ["all"]
  included_users        = ["All"]
  excluded_groups       = ["86a827be-9f2d-46fe-992e-9445ec10e840"]
  built_in_controls     = ["block"]
  operator              = "OR"
}

# Conditional access policy to block non-MacOS systems
module "block_non_macos" {
  source                = "./modules/conditional_access"
  policy_name           = "Conditional Access - Block Non-MacOS Systems"
  client_app_types      = ["all"]
  included_applications = ["All"]
  included_locations    = ["All"]
  excluded_locations    = [resource.azuread_named_location.esdc_ips.id]
  included_platforms    = ["all"]
  excluded_platforms    = ["macOS", "linux"]
  included_users        = ["All"]
  excluded_groups       = ["86a827be-9f2d-46fe-992e-9445ec10e840"]
  built_in_controls     = ["block"]
  operator              = "OR"
}

# Conditional access policy to block TC users portal access
module "block_tc_user_portal_access" {
  source                = "./modules/conditional_access"
  policy_name           = "Conditional Access - Block TC Users Portal Access"
  client_app_types      = ["all"]
  included_applications = ["797f4846-ba00-4fd7-ba43-dac1f8f63013"]
  included_locations    = ["All"]
  included_platforms    = ["all"]
  included_groups       = ["f587d598-8c31-4889-b8a7-e059c253ae84"]
  built_in_controls     = ["block"]
  operator              = "OR"
}
