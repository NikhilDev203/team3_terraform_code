terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = "Y1"  # Consumption tier for Functions

  tags = var.common_tags
}

# Patient Service Function App
resource "azurerm_windows_function_app" "patient_service" {
  name                       = var.patient_function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.main.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  https_only                 = true

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = var.application_insights_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = var.application_insights_key
    "AzureWebJobsStorage"                       = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
    "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
    "KeyVaultUri"                               = var.key_vault_uri
    "FUNCTIONS_WORKER_RUNTIME"                 = "dotnet"
    "FUNCTIONS_EXTENSION_VERSION"               = "~4"
  }

  site_config {
    always_on       = false
    use_32_bit_worker = false
    
    cors {
      allowed_origins = ["*"]
    }

    application_stack {
      dotnet_version              = "v6.0"
      use_dotnet_isolated_runtime = true
    }
  }

  virtual_network_subnet_id = var.app_subnet_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.common_tags

  depends_on = [azurerm_service_plan.main]
}

# Appointment Service Function App
resource "azurerm_windows_function_app" "appointment_service" {
  name                       = var.appointment_function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.main.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  https_only                 = true

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = var.application_insights_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = var.application_insights_key
    "AzureWebJobsStorage"                       = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
    "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${var.storage_account_access_key};EndpointSuffix=core.windows.net"
    "KeyVaultUri"                               = var.key_vault_uri
    "FUNCTIONS_WORKER_RUNTIME"                 = "dotnet"
    "FUNCTIONS_EXTENSION_VERSION"               = "~4"
  }

  site_config {
    always_on       = false
    use_32_bit_worker = false
    
    cors {
      allowed_origins = ["*"]
    }

    application_stack {
      dotnet_version              = "v6.0"
      use_dotnet_isolated_runtime = true
    }
  }

  virtual_network_subnet_id = var.app_subnet_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.common_tags

  depends_on = [azurerm_service_plan.main]
}
/*
# Network Interface for VM
resource "azurerm_network_interface" "devops_vm_nic" {
  name                = "nic-devops-vm"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.devops_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops_vm_pip.id
  }

  tags = var.common_tags
}

# Public IP for DevOps VM
resource "azurerm_public_ip" "devops_vm_pip" {
  name                = "pip-devops-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.common_tags
}

# DevOps VM
resource "azurerm_windows_virtual_machine" "devops_vm" {
  name                = var.devops_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.devops_vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.devops_vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.common_tags

  depends_on = [azurerm_network_interface.devops_vm_nic]
}

# Custom Script Extension for DevOps VM (Install Docker, Terraform, etc.)
resource "azurerm_virtual_machine_extension" "devops_vm_script" {
  name                       = "devops-vm-script"
  virtual_machine_id         = azurerm_windows_virtual_machine.devops_vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    "commandToExecute" = "powershell -Command \"$ProgressPreference='SilentlyContinue'; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')); choco install -y terraform docker-desktop git vscode azure-cli\""
  })
}
*/

# Storage Account for state files and logs
locals {
  storage_account_name = var.storage_account_name
}

# Outputs for creating App Gateway afterwards
locals {
  patient_function_app_hostname  = azurerm_windows_function_app.patient_service.default_hostname
  appointment_function_app_hostname = azurerm_windows_function_app.appointment_service.default_hostname
}
