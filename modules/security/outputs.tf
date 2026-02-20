output "key_vault_id" {
  value       = azurerm_key_vault.main.id
  description = "Key Vault ID"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.main.vault_uri
  description = "Key Vault URI"
}

output "key_vault_name" {
  value       = azurerm_key_vault.main.name
  description = "Key Vault Name"
}

output "function_apps_identity_id" {
  value       = azurerm_user_assigned_identity.function_apps.id
  description = "Managed Identity ID for Function Apps"
}

output "function_apps_identity_principal_id" {
  value       = azurerm_user_assigned_identity.function_apps.principal_id
  description = "Managed Identity Principal ID for Function Apps"
}

output "function_apps_identity_client_id" {
  value       = azurerm_user_assigned_identity.function_apps.client_id
  description = "Managed Identity Client ID for Function Apps"
}

output "vm_identity_id" {
  value       = azurerm_user_assigned_identity.vm_identity.id
  description = "Managed Identity ID for VM"
}

output "vm_identity_principal_id" {
  value       = azurerm_user_assigned_identity.vm_identity.principal_id
  description = "Managed Identity Principal ID for VM"
}

output "vm_identity_client_id" {
  value       = azurerm_user_assigned_identity.vm_identity.client_id
  description = "Managed Identity Client ID for VM"
}
