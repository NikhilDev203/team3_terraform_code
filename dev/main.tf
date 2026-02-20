terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Uncomment and configure if using remote state
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "stterraformstate"
  #   container_name       = "tfstate"
  #   key                  = "patient-service.tfstate"
  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name       = var.resource_group_name
  location   = var.location
  tags       = var.common_tags
}

# Monitoring Module
module "monitoring" {
  source = "../modules/monitoring"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  common_tags         = var.common_tags

  workspace_name = var.log_analytics_workspace_name
}

# Networking Module
module "networking" {
  source = "../modules/networking"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  common_tags         = var.common_tags

  vnet_name            = var.vnet_name
  vnet_address_space   = var.vnet_address_space
  agw_subnet_prefix    = var.agw_subnet_prefix
  app_subnet_prefix    = var.app_subnet_prefix
  pe_subnet_prefix     = var.pe_subnet_prefix
  devops_subnet_prefix = var.devops_subnet_prefix
}

# Storage Module
module "storage" {
  source = "../modules/storage"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  common_tags         = var.common_tags

  storage_account_name = var.storage_account_name
  acr_name             = var.acr_name
  pe_subnet_id         = module.networking.pe_subnet_id
  vnet_id              = module.networking.vnet_id

  depends_on = [module.networking]
}

# Security Module
module "security" {
  source = "../modules/security"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  common_tags         = var.common_tags

  key_vault_name = var.key_vault_name
  pe_subnet_id   = module.networking.pe_subnet_id
  vnet_id        = module.networking.vnet_id

  depends_on = [module.networking]
}

# Compute Module
module "compute" {
  source = "../modules/compute"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  common_tags         = var.common_tags

  app_service_plan_name          = var.app_service_plan_name
  patient_function_app_name      = var.patient_function_app_name
  appointment_function_app_name  = var.appointment_function_app_name
  app_subnet_id                  = module.networking.app_subnet_id
  
  storage_account_name           = module.storage.storage_account_name
  storage_account_access_key     = module.storage.storage_account_access_key
  application_insights_key       = module.monitoring.instrumentation_key
  key_vault_id                   = module.security.key_vault_id
  key_vault_uri                  = module.security.key_vault_uri

  devops_vm_name                 = var.devops_vm_name
  devops_subnet_id               = module.networking.devops_subnet_id
  devops_vm_size                 = var.devops_vm_size
  admin_username                 = var.admin_username
  admin_password                 = var.admin_password

  depends_on = [module.networking, module.storage, module.security, module.monitoring]
}

# App Gateway configuration will leverage the compute module outputs
