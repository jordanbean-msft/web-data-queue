variable "resource_group_name" {}
variable "location" {}
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

locals {
  storage_account_name               = lower("sa${var.resource_tags.app}${var.resource_tags.region}${var.resource_tags.environment}")
  storage_account_img_container_name = "img"
  sql_server_name                    = lower("sqls-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}")
  sql_web_portal_db_name             = "sqldb-webPortal-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  sql_admin_portal_db_name           = "sqldb-adminPortal-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
}
