output "id" {
  description = "The ID of the custom directory role."
  value       = azuread_custom_directory_role.this.id
}

output "display_name" {
  description = "The display name of the custom directory role."
  value       = azuread_custom_directory_role.this.display_name
}
