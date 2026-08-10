# Azure OpenAI Model Inventory

Generated 2026-08-10 from Azure Resource Graph + `az cognitiveservices account deployment list` across all accessible subscriptions.
Last updated 2026-08-10 after the AI Gateway consolidation removals (see [#94](https://github.com/cds-snc/cds-azure-resources/issues/94)).

No AI Foundry hubs/projects or `AIServices` accounts exist in the tenant — all resources are classic Azure OpenAI (`kind=OpenAI`) Cognitive Services accounts.

## Subscription reference

| Subscription                | ID                                     |
| --------------------------- | -------------------------------------- |
| CDS-AI                      | `c4122b45-f2e3-4873-a7fe-b94c1ad2589f` |
| DTO                         | `5617b0eb-50cc-4fe6-b57e-021e6ec245f0` |
| SRE Tools                   | `204b7832-86f3-4792-8e35-860862258324` |
| Legacy Resources And GitHub | `0fdba6f8-cf99-4daf-89bd-162f0f193802` |

---

## Part 1 — All deployed models in Azure

All deployments are `GlobalStandard` SKU unless noted.

### CDS-AI

| Resource group    | Account                   | Deployment             | Model                  | Version    | Capacity |
| ----------------- | ------------------------- | ---------------------- | ---------------------- | ---------- | -------- |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.6-luna           | gpt-5.6-luna           | 2026-07-09 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.6-sol            | gpt-5.6-sol            | 2026-07-09 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.6-terra          | gpt-5.6-terra          | 2026-07-09 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.5                | gpt-5.5                | 2026-04-24 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.4                | gpt-5.4                | 2026-03-05 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.4-mini           | gpt-5.4-mini           | 2026-03-17 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.4-nano           | gpt-5.4-nano           | 2026-03-17 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.3-codex          | gpt-5.3-codex          | 2026-02-24 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.2                | gpt-5.2                | 2025-12-11 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.2-codex          | gpt-5.2-codex          | 2026-01-14 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.1                | gpt-5.1                | 2025-11-13 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.1-codex          | gpt-5.1-codex          | 2025-11-13 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.1-codex-max      | gpt-5.1-codex-max      | 2025-12-04 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | gpt-5.1-codex-mini     | gpt-5.1-codex-mini     | 2025-11-13 | 10       |
| ai-gateway-openai | ai-gateway-openai-account | text-embedding-3-large | text-embedding-3-large | 1          | 10       |
| ai-gateway-openai | ai-gateway-openai-account | text-embedding-3-small | text-embedding-3-small | 1          | 10       |
| kvycenf-rg        | qualtrix-kvycenf          | qualtrix-gpt-4o        | gpt-4o                 | 2024-08-06 | 50       |
| yydpctx-rg        | qual-analysis-yydpctx     | qual-analysis-gpt-4o   | gpt-4o                 | 2024-08-06 | 50       |

### DTO

| Resource group     | Account            | Deployment             | Model                  | Version    | Capacity         |
| ------------------ | ------------------ | ---------------------- | ---------------------- | ---------- | ---------------- |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt-chat-latest | gpt-chat-latest        | 2026-05-05 | 200              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt51           | gpt-5.1                | 2025-11-13 | 400              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt5-mini       | gpt-5-mini             | 2025-08-07 | 400              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt5-nano       | gpt-5-nano             | 2025-08-07 | 200              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt41           | gpt-4.1                | 2025-04-14 | 400              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt41-mini      | gpt-4.1-mini           | 2025-04-14 | 400              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | gpt-4o                 | gpt-4o                 | 2024-11-20 | 200 (`Standard`) |
| nimwzfg-ai-answers | ai-answers-nimwzfg | openai-gpt4o-mini      | gpt-4o-mini            | 2024-07-18 | 200              |
| nimwzfg-ai-answers | ai-answers-nimwzfg | text-embedding-3-large | text-embedding-3-large | 1          | 200              |

### SRE Tools

| Resource group    | Account           | Deployment  | Model       | Version    | Capacity |
| ----------------- | ----------------- | ----------- | ----------- | ---------- | -------- |
| ctchvym-valentine | valentine-ctchvym | gpt-5-mini  | gpt-5-mini  | 2025-08-07 | 200      |
| ctchvym-valentine | valentine-ctchvym | gpt-4o-mini | gpt-4o-mini | 2024-07-18 | 200      |

### Legacy Resources And GitHub

No OpenAI accounts remain in this subscription.

### Non-OpenAI Cognitive Services accounts

| Subscription                | Resource group      | Account                | Kind            | Location |
| --------------------------- | ------------------- | ---------------------- | --------------- | -------- |
| Legacy Resources And GitHub | linguistic_services | linguistic-serv-global | TextTranslation | global   |

---

## Part 2 — Models deployed by Terraform in this repo

Defined in `terragrunt/openai_api_keys.tf` via the `modules/openai_api_key` module. Account and resource group names carry a random 7-character suffix generated by the module.

### `valentine_api_key` — RG `ctchvym-valentine` (SRE Tools)

| Deployment  | Model       | Version    |
| ----------- | ----------- | ---------- |
| gpt-5-mini  | gpt-5-mini  | 2025-08-07 |
| gpt-4o-mini | gpt-4o-mini | 2024-07-18 |

### `ai_answers_api_key` — RG `nimwzfg-ai-answers` (DTO)

| Deployment             | Model                  | Version                     |
| ---------------------- | ---------------------- | --------------------------- |
| gpt-4o                 | gpt-4o                 | 2024-11-20 (`Standard` SKU) |
| openai-gpt4o-mini      | gpt-4o-mini            | 2024-07-18                  |
| text-embedding-3-large | text-embedding-3-large | 1                           |
| openai-gpt41-mini      | gpt-4.1-mini           | 2025-04-14                  |
| openai-gpt41           | gpt-4.1                | 2025-04-14                  |
| openai-gpt5-mini       | gpt-5-mini             | 2025-08-07                  |
| openai-gpt5-nano       | gpt-5-nano             | 2025-08-07                  |
| openai-gpt51           | gpt-5.1                | 2025-11-13                  |
| openai-gpt51-chat      | gpt-5.1-chat           | 2025-11-13                  |

### `qualtrix_openai` — RG `kvycenf-rg` (CDS-AI)

| Deployment      | Model  | Version    |
| --------------- | ------ | ---------- |
| qualtrix-gpt-4o | gpt-4o | 2024-08-06 |

### `qual_analysis_openai` — RG `yydpctx-rg` (CDS-AI)

| Deployment           | Model  | Version    |
| -------------------- | ------ | ---------- |
| qual-analysis-gpt-4o | gpt-4o | 2024-08-06 |

---

## Part 3 — Decommissioned 2026-08-10

Removed as part of the AI Gateway consolidation ([#94](https://github.com/cds-snc/cds-azure-resources/issues/94)). Soft-deleted Cognitive Services accounts continue to hold their quota and block name reuse until purged.

| Account                | Subscription                | Resource group         | Model              | Freed TPM | How it was managed                                                                                  |
| ---------------------- | --------------------------- | ---------------------- | ------------------ | --------- | --------------------------------------------------------------------------------------------------- |
| cds-snc                | Legacy Resources And GitHub | openai-rg              | gpt-4o 2024-08-06  | 15030     | Manual (no IaC)                                                                                     |
| cds-notify-ai          | CDS-AI                      | cds-notify-rg          | gpt-4o 2024-05-13  | 1597      | Manual (no IaC)                                                                                     |
| cds-platform-ai        | CDS-AI                      | platform-ai-rg         | gpt-4o 2024-08-06  | 1004      | Manual (no IaC)                                                                                     |
| dev-ai-api-key-yazzttz | SRE Tools                   | yazzttz-dev-ai-api-key | gpt-5.1 2025-11-13 | 500       | `module "dev_ai_api_key"`, removed in [#95](https://github.com/cds-snc/cds-azure-resources/pull/95) |
| cds-sst-test           | Legacy Resources And GitHub | ops_calvin_test        | gpt-4o 2024-08-06  | 10        | Manual (no IaC)                                                                                     |

All five OpenAI accounts above have been deleted **and purged**.

**Quota released:** 18141 TPM, all in `canadaeast`. Post-purge `OpenAI.GlobalStandard.gpt-4o` usage is `0/90000` in Legacy and `100/90000` in CDS-AI (the residual 100 is qualtrix + qual-analysis at 50 each).

Quota does not transfer between buckets — it is scoped to `subscription × region × model × deployment type`. The AI Gateway sits in `CDS-AI / canadacentral`, so none of the released `canadaeast` capacity is directly available to it.

Resource groups `cds-notify-rg` and `ops_calvin_test` still exist; they hold non-OpenAI resources (Key Vault `kv-airesear135355726898`, storage `stairesearch135355726898` / `opsaitest`, and Event Grid system topics).

### Also removed, outside the OpenAI consolidation

| Account      | Subscription                | Resource group | Kind            | Status             |
| ------------ | --------------------------- | -------------- | --------------- | ------------------ |
| weblate-demo | Legacy Resources And GitHub | sre_ops        | TextTranslation | Deleted and purged |

TextTranslation accounts do not consume Azure OpenAI TPM quota, so no capacity was released.

---

## Notes

- **Drift:** `ai_answers_api_key` declares `openai-gpt51-chat` / `gpt-5.1-chat`, but the account has `openai-gpt-chat-latest` / `gpt-chat-latest` (2026-05-05) deployed instead.
- **Not managed by this repo:** `ai-gateway-openai-account` (managed in [cds-snc/ai-gateway](https://github.com/cds-snc/ai-gateway)) and both TextTranslation accounts.
