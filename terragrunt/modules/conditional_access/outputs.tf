output "policy_id" {
  value       = azuread_conditional_access_policy.this.id
  description = "ID of the created Conditional Access Policy"
}
