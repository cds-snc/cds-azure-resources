module "valentine_api_key" {
  source                     = "./modules/openai_api_key"
  providers = {
    azurerm = azurerm.sre_tools
  }
  name                       = "valentine"
  custom_subdomain_name      = "valentine"
  resource_group_name_prefix = "valentine"
  requestor_emails           = ["max.neuvians@cds-snc.ca"]

  openai_deployments = [{
    name = "gpt-5-mini"
    model = {
      name    = "gpt-5-mini"
      version = "2025-08-07"
    }
    sku = {
      capacity = 200
    }

    rai_policy_name = ""
    },
    {
      name = "gpt-4o-mini"
      model = {
        name    = "gpt-4o-mini"
        version = "2024-07-18"
      }
      sku = {
        capacity = 200
      }
      rai_policy_name = ""
  }]
}

module "ai_answers_api_key" {
  source                     = "./modules/openai_api_key"
  providers = {
    azurerm = azurerm.dto
  }
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
    sku = {
      name     = "Standard"
      capacity = 200
    }
    rai_policy_name = ""
    },
    {
      name = "openai-gpt4o-mini"
      model = {
        name    = "gpt-4o-mini"
        version = "2024-07-18"
      }
      sku = {
        capacity = 200
      }
      rai_policy_name = ""
    },
    {
      name = "text-embedding-3-large"
      model = {
        name    = "text-embedding-3-large"
        version = "1"
      }
      sku = {
        capacity = 200
      }

      rai_policy_name = ""
    },
    {
      name = "openai-gpt41-mini"
      model = {
        name    = "gpt-4.1-mini"
        version = "2025-04-14"
      }
      sku = {
        capacity = 400
      }

      rai_policy_name = ""
    },
    {
      name = "openai-gpt41"
      model = {
        name    = "gpt-4.1"
        version = "2025-04-14"
      }
      sku = {
        capacity = 400
      }

      rai_policy_name = ""
    },
    {
      name = "openai-gpt5-mini"
      model = {
        name    = "gpt-5-mini"
        version = "2025-08-07"
      }
      sku = {
        capacity = 400
      }

      rai_policy_name = ""
    },
    {
      name = "openai-gpt5-nano"
      model = {
        name    = "gpt-5-nano"
        version = "2025-08-07"
      }
      sku = {
        capacity = 200
      }

      rai_policy_name = ""
    },
    {
      name = "openai-gpt51"
      model = {
        name    = "gpt-5.1"
        version = "2025-11-13"
      }
      sku = {
        capacity = 400
      }

      rai_policy_name = ""
    },
    {
      name = "openai-gpt51-chat"
      model = {
        name    = "gpt-5.1-chat"
        version = "2025-11-13"
      }
      sku = {
        capacity = 200
      }

      rai_policy_name = ""
    }
  ]
}


module "dev_ai_api_key" {
  source                     = "./modules/openai_api_key"
  providers = {
    azurerm = azurerm.sre_tools
  }
  name                       = "dev-ai-api-key"
  custom_subdomain_name      = "dev-ai-api-key"
  resource_group_name_prefix = "dev-ai-api-key"
  requestor_emails           = ["sylvia.mclaughlin@cds-snc.ca"]

  openai_deployments = [{
    name = "openai-gpt51"
    model = {
      name    = "gpt-5.1"
      version = "2025-11-13"
    }
    sku = {
      capacity = 500
    }

    rai_policy_name = ""
    }
  ]
}
