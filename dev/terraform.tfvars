subscription_id     = ""  # Set your Azure subscription ID
resource_group_name = "rg-patient-service"
location            = "eastus"
environment         = "dev"

common_tags = {
  Environment = "dev"
  Project     = "PatientService"
  Owner       = "HealthcareTeam"
  CreatedBy   = "Terraform"
}

# Networking
vnet_name            = "vnet-patient-service"
vnet_address_space   = ["10.0.0.0/16"]
agw_subnet_prefix    = "10.0.1.0/24"
app_subnet_prefix    = "10.0.2.0/24"
pe_subnet_prefix     = "10.0.3.0/24"
devops_subnet_prefix = "10.0.4.0/24"

# Storage
storage_account_name = "stpatientservicedata"
acr_name             = "acrpatientservice"

# Security
key_vault_name = "kv-patient-service"

# Compute
app_service_plan_name         = "asp-patient-service"
patient_function_app_name     = "func-patient-service"
appointment_function_app_name = "func-appointment-service"
devops_vm_name                = "vm-cicd-agent"
devops_vm_size                = "Standard_B2s"
admin_username                = "azureuser"
admin_password                = "Change@Password123!"  # Change this in production

# Monitoring
log_analytics_workspace_name = "law-patient-service"
application_insights_name    = "appi-patient-service"
