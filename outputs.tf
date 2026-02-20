output "resource_group_id" {
  value       = azurerm_resource_group.main.id
  description = "Resource Group ID"
}

output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Resource Group Name"
}

# Networking Outputs
output "vnet_id" {
  value       = module.networking.vnet_id
  description = "Virtual Network ID"
}

output "agw_subnet_id" {
  value       = module.networking.agw_subnet_id
  description = "App Gateway Subnet ID"
}

output "app_subnet_id" {
  value       = module.networking.app_subnet_id
  description = "App Service Subnet ID"
}

output "pe_subnet_id" {
  value       = module.networking.pe_subnet_id
  description = "Private Endpoints Subnet ID"
}

output "devops_subnet_id" {
  value       = module.networking.devops_subnet_id
  description = "DevOps Subnet ID"
}

# Storage Outputs
output "storage_account_id" {
  value       = module.storage.storage_account_id
  description = "Storage Account ID"
}

output "storage_account_name" {
  value       = module.storage.storage_account_name
  description = "Storage Account Name"
}

output "acr_id" {
  value       = module.storage.acr_id
  description = "Azure Container Registry ID"
}

output "acr_login_server" {
  value       = module.storage.acr_login_server
  description = "ACR Login Server"
}

# Security Outputs
output "key_vault_id" {
  value       = module.security.key_vault_id
  description = "Key Vault ID"
}

output "key_vault_uri" {
  value       = module.security.key_vault_uri
  description = "Key Vault URI"
}

# Compute Outputs
output "patient_function_app_id" {
  value       = module.compute.patient_function_app_id
  description = "Patient Service Function App ID"
}

output "patient_function_app_default_hostname" {
  value       = module.compute.patient_function_app_default_hostname
  description = "Patient Service Function App Hostname"
}

output "appointment_function_app_id" {
  value       = module.compute.appointment_function_app_id
  description = "Appointment Service Function App ID"
}

output "appointment_function_app_default_hostname" {
  value       = module.compute.appointment_function_app_default_hostname
  description = "Appointment Service Function App Hostname"
}
/*
output "devops_vm_id" {
  value       = module.compute.devops_vm_id
  description = "DevOps VM ID"
}

output "devops_vm_public_ip" {
  value       = module.compute.devops_vm_public_ip
  description = "DevOps VM Public IP"
}
*/
# Monitoring Outputs
output "log_analytics_workspace_id" {
  value       = module.monitoring.workspace_id
  description = "Log Analytics Workspace ID"
}

output "application_insights_id" {
  value       = module.monitoring.app_insights_id
  description = "Application Insights ID"
}

output "application_insights_instrumentation_key" {
  value       = module.monitoring.instrumentation_key
  sensitive   = true
  description = "Application Insights Instrumentation Key"
}
