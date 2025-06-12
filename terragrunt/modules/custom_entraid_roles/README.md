# custom_entraid_roles Terraform Module

This module provisions an Azure AD custom directory role using the `azuread_custom_directory_role` resource.

## Usage

```hcl
module "custom_entraid_roles" {
  source       = "./modules/custom_entraid_roles"
  display_name = "My Custom Role"
  description  = "Custom role for special permissions."
  permissions  = [
    "microsoft.directory/applications/allProperties/read",
    # Add more permissions as needed
  ]
  enabled      = true         # Optional, default: true
  version      = "1.0"        # Optional, default: "1.0"
}
```

## Inputs
- `display_name` (string, required): The display name for the custom directory role.
- `description` (string, optional): The description for the custom directory role.
- `permissions` (set(string), required): A set of permission values to assign to the role.
- `enabled` (bool, optional): Whether the custom directory role is enabled. Default is `true`.
- `version` (string, optional): The version of the custom directory role. Default is `"1.0"`.

## Outputs
- `id`: The ID of the custom directory role.
- `display_name`: The display name of the custom directory role.
