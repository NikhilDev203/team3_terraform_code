output "vnet_id" {
  value       = azurerm_virtual_network.main.id
  description = "Virtual Network ID"
}

output "vnet_name" {
  value       = azurerm_virtual_network.main.name
  description = "Virtual Network Name"
}

output "agw_subnet_id" {
  value       = azurerm_subnet.agw.id
  description = "App Gateway Subnet ID"
}

output "app_subnet_id" {
  value       = azurerm_subnet.app.id
  description = "App Service Subnet ID"
}

output "pe_subnet_id" {
  value       = azurerm_subnet.pe.id
  description = "Private Endpoints Subnet ID"
}

output "devops_subnet_id" {
  value       = azurerm_subnet.devops.id
  description = "DevOps Subnet ID"
}

output "agw_nsg_id" {
  value       = azurerm_network_security_group.agw_nsg.id
  description = "App Gateway NSG ID"
}

output "app_nsg_id" {
  value       = azurerm_network_security_group.app_nsg.id
  description = "App Service NSG ID"
}

output "pe_nsg_id" {
  value       = azurerm_network_security_group.pe_nsg.id
  description = "Private Endpoints NSG ID"
}

output "devops_nsg_id" {
  value       = azurerm_network_security_group.devops_nsg.id
  description = "DevOps NSG ID"
}

output "private_dns_zone_id" {
  value       = azurerm_private_dns_zone.azure_services.id
  description = "Private DNS Zone ID"
}
