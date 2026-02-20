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

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "agw_subnet_prefix" {
  type        = string
  description = "Address prefix for App Gateway subnet"
}

variable "app_subnet_prefix" {
  type        = string
  description = "Address prefix for App subnet"
}

variable "pe_subnet_prefix" {
  type        = string
  description = "Address prefix for Private Endpoints subnet"
}

variable "devops_subnet_prefix" {
  type        = string
  description = "Address prefix for DevOps subnet"
}
