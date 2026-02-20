output "storage_account_id" {
  value       = azurerm_storage_account.main.id
  description = "Storage Account ID"
}

output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "Storage Account Name"
}

output "storage_account_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
  description = "Storage Account Primary Access Key"
}

output "storage_account_connection_string" {
  value       = azurerm_storage_account.main.primary_blob_connection_string
  sensitive   = true
  description = "Storage Account Blob Connection String"
}

output "acr_id" {
  value       = azurerm_container_registry.main.id
  description = "Azure Container Registry ID"
}

output "acr_login_server" {
  value       = azurerm_container_registry.main.login_server
  description = "ACR Login Server"
}

output "acr_admin_username" {
  value       = azurerm_container_registry.main.admin_username
  sensitive   = true
  description = "ACR Admin Username"
}

output "storage_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "Storage Account Blob Endpoint"
}
