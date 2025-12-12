resource "azuread_named_location" "canada" {
  display_name = "Canada Only"
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

module "block_non_browser" {
  source = "./modules/conditional_access"

  policy_name = "Block Non-Browser Access"
  state       = "enabled"

  client_app_types = ["exchangeActiveSync", "mobileAppsAndDesktopClients", "other"]

  included_applications = ["All"]
  excluded_applications = ["797f4846-ba00-4fd7-ba43-dac1f8f63013"]

  included_locations = ["All"]

  included_platforms = ["all"]

  included_users  = ["All"]
  excluded_groups = ["86a827be-9f2d-46fe-992e-9445ec10e840", "9c8babe3-fe86-42b1-ace6-16734f559c60", "dda4f58f-e024-40da-9403-761270c5cc47"]

  built_in_controls = ["block"]
  operator          = "OR"
}

module "block_out_of_canada" {
  source = "./modules/conditional_access"

  policy_name = "Block out of Canada"
  state       = "enabled"

  client_app_types = ["all"]

  included_applications = ["All"]

  included_locations = ["All"]
  excluded_locations = [
    azuread_named_location.canada.object_id,
    azuread_named_location.united_states.object_id,
  ]

  included_platforms = ["all"]

  included_users  = ["All"]
  excluded_groups = ["86a827be-9f2d-46fe-992e-9445ec10e840"]

  built_in_controls = ["block"]
  operator          = "OR"
}

module "block_non_macos" {
  source = "./modules/conditional_access"

  policy_name = "Block Non-MacOS Systems"
  state       = "enabled"

  client_app_types = ["all"]

  included_applications = ["All"]

  included_locations = ["All"]
  excluded_locations = [
    azuread_named_location.esdc_ips.object_id,
  ]

  excluded_platforms = ["macOS", "linux"]
  included_platforms = ["all"]

  included_users  = ["All"]
  excluded_users  = ["GuestsOrExternalUsers"]
  excluded_groups = ["86a827be-9f2d-46fe-992e-9445ec10e840", "bec61a23-7411-4854-af2e-ecc7391f5b90"]

  built_in_controls = ["block"]
  operator          = "OR"
}

module "block_tc_user_portal_access" {
  source = "./modules/conditional_access"

  policy_name = "Block TC Users Portal Access"
  state       = "enabled"

  client_app_types = ["all"]

  included_applications = ["797f4846-ba00-4fd7-ba43-dac1f8f63013"]

  included_groups = ["f587d598-8c31-4889-b8a7-e059c253ae84"]

  built_in_controls = ["block"]
  operator          = "OR"
}

module "require_mfa_canada" {
  source = "./modules/conditional_access"

  policy_name = "Require MFA for Application Administrators in Canada"
  state       = "enabled"

  client_app_types = ["all"]

  included_applications = ["All"]

  included_locations = [
    azuread_named_location.canada.object_id
  ]

  included_roles = ["9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3"]

  device_filter = {
    mode = "include"
    rule = "device.isCompliant -ne True"
  }

  built_in_controls = ["mfa"]
  operator          = "OR"
}
