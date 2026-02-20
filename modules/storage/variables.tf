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

variable "storage_account_name" {
  type        = string
  description = "Name of storage account (must be globally unique)"
}

variable "acr_name" {
  type        = string
  description = "Name of Azure Container Registry (must be globally unique)"
}

variable "pe_subnet_id" {
  type        = string
  description = "ID of the subnet for private endpoints"
}

variable "vnet_id" {
  type        = string
  description = "ID of the virtual network"
  default     = ""
}
