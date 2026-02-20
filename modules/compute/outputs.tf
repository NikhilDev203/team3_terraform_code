output "app_service_plan_id" {
  value       = azurerm_service_plan.main.id
  description = "App Service Plan ID"
}

output "patient_function_app_id" {
  value       = azurerm_windows_function_app.patient_service.id
  description = "Patient Service Function App ID"
}

output "patient_function_app_name" {
  value       = azurerm_windows_function_app.patient_service.name
  description = "Patient Service Function App Name"
}

output "patient_function_app_default_hostname" {
  value       = azurerm_windows_function_app.patient_service.default_hostname
  description = "Patient Service Function App Hostname"
}

output "patient_function_app_principal_id" {
  value       = azurerm_windows_function_app.patient_service.identity[0].principal_id
  description = "Patient Service Function App Managed Identity Principal ID"
}

output "appointment_function_app_id" {
  value       = azurerm_windows_function_app.appointment_service.id
  description = "Appointment Service Function App ID"
}

output "appointment_function_app_name" {
  value       = azurerm_windows_function_app.appointment_service.name
  description = "Appointment Service Function App Name"
}

output "appointment_function_app_default_hostname" {
  value       = azurerm_windows_function_app.appointment_service.default_hostname
  description = "Appointment Service Function App Hostname"
}

output "appointment_function_app_principal_id" {
  value       = azurerm_windows_function_app.appointment_service.identity[0].principal_id
  description = "Appointment Service Function App Managed Identity Principal ID"
}

output "devops_vm_id" {
  value       = azurerm_windows_virtual_machine.devops_vm.id
  description = "DevOps VM ID"
}

output "devops_vm_name" {
  value       = azurerm_windows_virtual_machine.devops_vm.name
  description = "DevOps VM Name"
}

output "devops_vm_public_ip" {
  value       = azurerm_public_ip.devops_vm_pip.ip_address
  description = "DevOps VM Public IP"
}

output "devops_vm_private_ip" {
  value       = azurerm_network_interface.devops_vm_nic.private_ip_address
  description = "DevOps VM Private IP"
}

output "devops_vm_principal_id" {
  value       = azurerm_windows_virtual_machine.devops_vm.identity[0].principal_id
  description = "DevOps VM Managed Identity Principal ID"
}
