variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of App Service Plan"
}

variable "patient_function_app_name" {
  type        = string
  description = "Name of Patient Service Function App"
}

variable "appointment_function_app_name" {
  type        = string
  description = "Name of Appointment Service Function App"
}

variable "app_subnet_id" {
  type        = string
  description = "ID of the App Service subnet"
}

variable "storage_account_name" {
  type        = string
  description = "Name of storage account"
}

variable "storage_account_access_key" {
  type        = string
  description = "Storage account access key"
  sensitive   = true
}

variable "application_insights_key" {
  type        = string
  description = "Application Insights instrumentation key"
  sensitive   = true
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault ID"
}

variable "key_vault_uri" {
  type        = string
  description = "Key Vault URI"
  default     = ""
}

variable "devops_vm_name" {
  type        = string
  description = "Name of DevOps VM"
}

variable "devops_subnet_id" {
  type        = string
  description = "ID of the DevOps subnet"
}

variable "devops_vm_size" {
  type        = string
  description = "Size of DevOps VM"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for DevOps VM"
  sensitive   = true
}

variable "admin_password" {
  type        = string
  description = "Admin password for DevOps VM"
  sensitive   = true
}
