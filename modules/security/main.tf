terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure Key Vault
resource "azurerm_key_vault" "main" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enabled_for_disk_encryption = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = []
  }

  tags = var.common_tags
}

# Private Endpoint for Key Vault
resource "azurerm_private_endpoint" "keyvault_pe" {
  name                = "pe-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "psc-keyvault"
    private_connection_resource_id = azurerm_key_vault.main.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  tags = var.common_tags
}

# Private DNS Zone for Key Vault
resource "azurerm_private_dns_zone" "keyvault_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name

  tags = var.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "keyvault_link" {
  name                  = "vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_dns_a_record" "keyvault_dns" {
  name                = var.key_vault_name
  zone_name           = azurerm_private_dns_zone.keyvault_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.keyvault_pe.private_service_connection[0].private_ip_address]
}

# Current Azure Context
data "azurerm_client_config" "current" {}

# Key Vault Access Policy for Terraform
resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id       = azurerm_key_vault.main.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Update",
    "SetRotationPolicy"
  ]

  secret_permissions = [
    "Set",
    "Get",
    "Delete",
    "Purge",
    "Recover",
    "List"
  ]

  certificate_permissions = [
    "Create",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Update"
  ]
}

# Sample Secrets - Update with your actual values
resource "azurerm_key_vault_secret" "db_connection_string" {
  name            = "db-connection-string"
  value           = "Server=localhost;Database=PatientDB;User Id=admin;Password=YourPassword;"
  key_vault_id    = azurerm_key_vault.main.id
  tags            = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

resource "azurerm_key_vault_secret" "app_insights_key" {
  name            = "app-insights-instrumentation-key"
  value           = "placeholder-instrumentation-key"
  key_vault_id    = azurerm_key_vault.main.id
  tags            = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

resource "azurerm_key_vault_secret" "storage_account_key" {
  name            = "storage-account-key"
  value           = "placeholder-storage-key"
  key_vault_id    = azurerm_key_vault.main.id
  tags            = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

# Managed Identity for Function Apps
resource "azurerm_user_assigned_identity" "function_apps" {
  name                = "id-function-apps"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.common_tags
}

# Key Vault Access Policy for Function Apps
resource "azurerm_key_vault_access_policy" "function_apps" {
  key_vault_id       = azurerm_key_vault.main.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_user_assigned_identity.function_apps.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]

  depends_on = [azurerm_key_vault_access_policy.terraform]
}

# Managed Identity for VM
resource "azurerm_user_assigned_identity" "vm_identity" {
  name                = "id-devops-vm"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.common_tags
}

# Key Vault Access Policy for VM
resource "azurerm_key_vault_access_policy" "vm" {
  key_vault_id       = azurerm_key_vault.main.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_user_assigned_identity.vm_identity.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]

  depends_on = [azurerm_key_vault_access_policy.terraform]
}
