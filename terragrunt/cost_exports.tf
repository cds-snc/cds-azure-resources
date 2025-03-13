module "daily_cost_export" {
  source                      = "./modules/cost_exports"
  name                        = "Daily Cost Export"
  billing_account_id          = "7039692"
  recurrence_type             = "Daily"
  recurring_period_start_date = "2025-03-01T00:00:00Z"
  recurring_period_end_date   = "2035-03-01T00:00:00Z"

  # Provide export data opptions
  type       = "ActualCost"
  time_frame = "MonthToDate"
}
