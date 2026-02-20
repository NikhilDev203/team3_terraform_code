variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-patient-service"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"
}

variable "common_tags" {
  type = object({
    Environment = string
    Project     = string
    Owner       = string
    CreatedBy   = string
  })
  description = "Common tags to apply to all resources"
  default = {
    Environment = "dev"
    Project     = "PatientService"
    Owner       = "HealthcareTeam"
    CreatedBy   = "Terraform"
  }
}

# Networking Variables
variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
  default     = "vnet-patient-service"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "agw_subnet_prefix" {
  type        = string
  description = "Address prefix for App Gateway subnet"
  default     = "10.0.1.0/24"
}

variable "app_subnet_prefix" {
  type        = string
  description = "Address prefix for App subnet"
  default     = "10.0.2.0/24"
}

variable "pe_subnet_prefix" {
  type        = string
  description = "Address prefix for Private Endpoints subnet"
  default     = "10.0.3.0/24"
}

variable "devops_subnet_prefix" {
  type        = string
  description = "Address prefix for DevOps subnet"
  default     = "10.0.4.0/24"
}

# Storage Variables
variable "storage_account_name" {
  type        = string
  description = "Name of storage account (must be globally unique)"
  default     = "stpatientservicedata"
}

variable "acr_name" {
  type        = string
  description = "Name of Azure Container Registry"
  default     = "acrpatientservice"
}

# Security Variables
variable "key_vault_name" {
  type        = string
  description = "Name of Azure Key Vault"
  default     = "kv-patient-service"
}

# Compute Variables
variable "app_service_plan_name" {
  type        = string
  description = "Name of App Service Plan"
  default     = "asp-patient-service"
}

variable "patient_function_app_name" {
  type        = string
  description = "Name of Patient Service Function App"
  default     = "func-patient-service"
}

variable "appointment_function_app_name" {
  type        = string
  description = "Name of Appointment Service Function App"
  default     = "func-appointment-service"
}

variable "devops_vm_name" {
  type        = string
  description = "Name of DevOps VM"
  default     = "vm-cicd-agent"
}

variable "devops_vm_size" {
  type        = string
  description = "Size of DevOps VM"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for DevOps VM"
  default     = "azureuser"
  sensitive   = true
}

variable "admin_password" {
  type        = string
  description = "Admin password for DevOps VM"
  sensitive   = true
}

# Monitoring Variables
variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of Log Analytics Workspace"
  default     = "law-patient-service"
}

variable "application_insights_name" {
  type        = string
  description = "Name of Application Insights"
  default     = "appi-patient-service"
}
