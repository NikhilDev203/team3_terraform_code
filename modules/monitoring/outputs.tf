output "workspace_id" {
  value       = azurerm_log_analytics_workspace.main.id
  description = "Log Analytics Workspace ID"
}

output "workspace_name" {
  value       = azurerm_log_analytics_workspace.main.name
  description = "Log Analytics Workspace Name"
}

output "app_insights_id" {
  value       = azurerm_application_insights.main.id
  description = "Application Insights ID"
}

output "app_insights_name" {
  value       = azurerm_application_insights.main.name
  description = "Application Insights Name"
}

output "instrumentation_key" {
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
  description = "Application Insights Instrumentation Key"
}

output "connection_string" {
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
  description = "Application Insights Connection String"
}

output "action_group_id" {
  value       = azurerm_monitor_action_group.main.id
  description = "Monitor Action Group ID"
}
