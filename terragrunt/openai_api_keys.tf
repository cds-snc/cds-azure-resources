module "valentine_api_key" {
  source                     = "./modules/openai_api_key"
  subscription_id            = "204b7832-86f3-4792-8e35-860862258324" # SRE Tools subscription
  name                       = "valentine"
  custom_subdomain_name      = "valentine"
  resource_group_name_prefix = "valentine"
}

module "ai_answers_api_key" {
  source                     = "./modules/openai_api_key"
  subscription_id            = "5617b0eb-50cc-4fe6-b57e-021e6ec245f0" # DTO subscription
  name                       = "ai-answers"
  custom_subdomain_name      = "ai-answers"
  resource_group_name_prefix = "ai-answers"
}
