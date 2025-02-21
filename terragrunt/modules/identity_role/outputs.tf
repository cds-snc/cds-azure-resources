output "service_principal_id" {
  description = "The object ID of the created Service Principal (if applicable)"
  value       = var.create_service_principal ? azuread_service_principal.sp[0].id : null
}

output "service_principal_client_id" {
  description = "The client ID of the created Service Principal (if applicable)"
  value       = var.create_service_principal ? azuread_application.sp_app[0].client_id : null
}

output "managed_identity_id" {
  description = "The principal ID of the created Managed Identity (if applicable)"
  value       = var.create_managed_identity ? azurerm_user_assigned_identity.managed_identity[0].principal_id : null
}

output "role_assignment_id" {
  description = "The ID of the role assignment"
  value       = var.create_service_principal ? azurerm_role_assignment.role_assignment_sp[0].id : azurerm_role_assignment.role_assignment_mi[0].id
  sensitive   = true
}

output "service_principal_password" {
  description = "The password of the created Service Principal (if applicable)"
  value       = var.create_service_principal ? azuread_service_principal_password.sp_password[0].value : null
  sensitive   = true
}
