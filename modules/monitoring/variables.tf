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

variable "workspace_name" {
  type        = string
  description = "Name of Log Analytics Workspace"
}

variable "application_insights_name" {
  type        = string
  description = "Name of Application Insights"
  default     = "appi-default"
}
