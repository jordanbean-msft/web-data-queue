variable "resource_group_name" {}
variable "location" {}
variable "app" {}
variable "region" {}
variable "environment" {}
variable "resource_tags" {
  type = map(any)
}
variable "vnet_name" {}
variable "vnet_data_subnet_name" {}
variable "log_analytics_workspace_name" {}
variable "application_insights_name" {}
variable "key_vault_name" {}
variable "user_assigned_identity_name" {}
variable "admin_upn" {}
variable "sql_username_secret_name" {
  sensitive = true
}
variable "sql_password_secret_name" {
  sensitive = true
}

locals {
  storage_account_name               = lower("sa${var.app}${var.region}${var.environment}")
  storage_account_img_container_name = "img"
  sql_server_name                    = lower("sqls-${var.app}-${var.region}-${var.environment}")
  sql_web_portal_db_name             = "sqldb-webPortal-${var.app}-${var.region}-${var.environment}"
  sql_admin_portal_db_name           = "sqldb-adminPortal-${var.app}-${var.region}-${var.environment}"
}
