module "valentine_api_key" {
  source                     = "./modules/openai_api_key"
  subscription_id            = "204b7832-86f3-4792-8e35-860862258324" # SRE Tools subscription
  name                       = "valentine"
  custom_subdomain_name      = "valentine"
  resource_group_name_prefix = "valentine"
  requestor_emails           = ["max.neuvians@cds-snc.ca"]
}

module "ai_answers_api_key" {
  source                     = "./modules/openai_api_key"
  subscription_id            = "5617b0eb-50cc-4fe6-b57e-021e6ec245f0" # DTO subscription
  name                       = "ai-answers"
  custom_subdomain_name      = "ai-answers"
  resource_group_name_prefix = "ai-answers"
  budget_amount              = 50
  requestor_emails           = ["HamzaBelal.Aburaneh@cds-snc.ca"]

  # Create additional deployments for AI answers. Deployments include gpt-40, text-embedding-3-small and the default gpt-4o-mini
  openai_deployments = [{
    name = "gpt-4o"
    model = {
      name    = "gpt-4o"
      version = "2024-11-20"
    }
    rai_policy_name = ""
    },
    {
      name = "openai-gpt4o-mini"
      model = {
        name    = "gpt-4o-mini"
        version = "2024-07-18"
      }
      rai_policy_name = ""
    }
  ]
}
