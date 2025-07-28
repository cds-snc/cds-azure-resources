locals {
  # Define subscriptions and their configurations
  subscriptions = {
    "gc-issue-and-verify-test" = {
      subscription_id = "dafbd4a8-e33d-4f63-8501-a8fe1e11bb08"
    }
    "gc-issue-and-verify-api-gateway-non-prod" = {
      subscription_id = "bffddff3-1ae8-458d-a06e-ee015e02065e"
    }
    "gc-issue-and-verify-dev" = {
      subscription_id = "5bb2f651-8e02-4875-a81a-7bbc41e6fbc9"
    }
    "gc-issue-and-verify-partner-test" = {
      subscription_id = "0e8d47b0-88f3-457e-acae-05f976df1369"
    }
    "gc-issue-and-verify-production" = {
      subscription_id = "708c89c6-dfca-4053-8910-1229b74e2e7d"
    }
    "dto" = {
      subscription_id = "5617b0eb-50cc-4fe6-b57e-021e6ec245f0"
    }
    "reporting" = {
      subscription_id = "2401a870-e4dd-4c61-ac84-0eaaafdb9039"
    }
    "ssc-compliance-as-code" = {
      subscription_id = "8dbb5e0d-191a-401f-a9fb-8adc2325905c"
    }
    "cds-ai" = {
      subscription_id = "c4122b45-f2e3-4873-a7fe-b94c1ad2589f"
    }
    "azure-cbs-agent" = {
      subscription_id = "c2a4913a-53e5-464c-b4cb-65e7a4853343"
    }
    "legacy-resources-and-github" = {
      subscription_id = "0fdba6f8-cf99-4daf-89bd-162f0f193802"
    }
    "sre-tools" = {
      subscription_id = "204b7832-86f3-4792-8e35-860862258324"
    }
    "cds-snc-connectivity" = {
      subscription_id = "51ea34de-cc53-4e2a-968c-855ecdebe31f"
    }
    "cds-snc-identity" = {
      subscription_id = "98f7db6a-81a0-4d58-9be3-cc458ec9f491"
    }
    "cds-snc-management" = {
      subscription_id = "6881deca-df81-4b95-ad54-103b0b100a1d"
    }
    "test-scratch" = {
      subscription_id = "b5efb34a-d681-435b-8101-162842de9c80"
    }
    "gc-issue-and-verify-scratch-lz---thomas-gohard" = {
      subscription_id = "981ee6e7-d91d-4f3e-b7b1-04d066a882f2"
    }
    "gc-issue-and-verify-scratch-lz---david-mason" = {
      subscription_id = "05d69a1f-3758-433a-9187-4c7646d4cb73"
    }
    "sylvia-mclaughlin-scratch" = {
      subscription_id = "93a795d2-1f3e-4ced-a3c2-8486bc3f670f"
    }
    "gc-issue-and-verify-scratch-lz---eric-ehret" = {
      subscription_id = "058ecc6c-c7e9-4463-93d1-cfc355ac6ca9"
    }
    "dctest" = {
      subscription_id = "0b2356e2-6119-4d57-8b0d-6e0d8e6a5abb"
    }
    "cds-hub-network" = {
      subscription_id = "707f2266-324c-47d8-809f-07801f4b425a"
    }
    "gc-issue-and-verify-dev" = {
      subscription_id = "6b7bf244-a594-46c7-b0d4-2c401a79b8db"
    }
    "terraform-remote-state" = {
      subscription_id = "cc310d9f-9276-4b2d-bde1-70cba9bb4df5"
    }
    "gc-issue-and-verify-staging" = {
      subscription_id = "b2c9446a-902c-48fa-9391-34adfd3ce131"
    }
    "adam-andrews-scratch" = {
      subscription_id = "1130057c-9a5f-418c-b5a8-7b5f5926578d"
    }
  }
}

# Create Service Health alerts for each subscription
module "service_health_alerts" {
  source = "./modules/azure_service_health_alert"

  for_each = local.subscriptions

  subscription_id   = each.value.subscription_id
  alert_name        = "${upper(replace(each.key, "-", " "))} Service Health Alert"
  alert_description = "Service Health alerts for ${replace(each.key, "-", " ")} subscription"

  # Use the existing SRE action group from scheduled_query_alert_rules.tf
  action_group_id = resource.azurerm_monitor_action_group.SRE_GR_AG.id

  tags = local.common_tags
}
