variable "resource_group_name" {}
variable "location" {}
variable "app" {}
variable "region" {}
variable "environment" {}
variable "resource_tags" {
  type = map(any)
}
variable "vnet_name" {}
variable "vnet_app_internal_subnet_name" {}
variable "vnet_app_external_subnet_name" {}
variable "vnet_app_queue_subnet_name" {}
variable "log_analytics_workspace_name" {}
variable "application_insights_name" {}
variable "key_vault_name" {}
variable "private_dns_zone_name" {}
variable "user_assigned_identity_name" {}
variable "vm_queue_username_secret_name" {
  sensitive = true
}
variable "vm_queue_password_secret_name" {
  sensitive = true
}
variable "sql_username_secret_name" {
  sensitive = true
}
variable "sql_password_secret_name" {
  sensitive = true
}
variable "api_management_publisher_email" {}
variable "api_management_sku" {}
variable "app_service_plan_sku" {}
variable "vnet_api_management_subnet_name" {}

variable "api_management_publisher_name" {}

locals {
  app_service_plan_internal_name = "asp-internal-${var.app}-${var.region}-${var.environment}"
  app_service_plan_external_name = "asp-external-${var.app}-${var.region}-${var.environment}"
  app_service_web_portal_name    = "wa-webPortal-${var.app}-${var.region}-${var.environment}"
  app_service_admin_portal_name  = "wa-adminPortal-${var.app}-${var.region}-${var.environment}"
  vm_queue_name                  = "vmQueue"
  vm_queue_nic_name              = "nic-vmQueue-${var.app}${var.region}${var.environment}"
  api_management_name            = "apim-${var.app}-${var.region}-${var.environment}"
}
