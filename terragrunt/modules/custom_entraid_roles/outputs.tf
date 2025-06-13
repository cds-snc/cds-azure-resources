output "object_id" {
  description = "The objectID of the custom directory role."
  value       = azuread_custom_directory_role.this.object_id
}

output "display_name" {
  description = "The display name of the custom directory role."
  value       = azuread_custom_directory_role.this.display_name
}
