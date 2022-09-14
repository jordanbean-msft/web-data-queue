variable "resource_group_name" {}
variable "location" {}
variable "app" {}
variable "region" {}
variable "environment" {}
variable "resource_tags" {
  type = map(any)
}
variable "vm_queue_username_secret_value" {
  sensitive = true
}
variable "vm_queue_password_secret_value" {
  sensitive = true
}
variable "sql_username_secret_value" {
  sensitive = true
}
variable "sql_password_secret_value" {
  sensitive = true
}
variable "admin_upn" {
  sensitive = true
}
variable "pipeline_spn_object_id" {

}

locals {
  log_analytics_workspace_name  = "la-${var.app}-${var.region}-${var.environment}"
  application_insights_name     = "ai-${var.app}-${var.region}-${var.environment}"
  key_vault_name                = "kv-${var.app}${var.environment}-01"
  private_dns_zone_name         = "${var.environment}.${var.app}.com"
  user_assigned_identity_name   = "mi-${var.app}-${var.region}-${var.environment}"
  vm_queue_username_secret_name = "vmQueue${var.app}${var.region}${var.environment}-username"
  vm_queue_password_secret_name = "vmQueue${var.app}${var.region}${var.environment}-password"
  sql_username_secret_name      = "sqls-${var.app}-${var.region}-${var.environment}-username"
  sql_password_secret_name      = "sqls-${var.app}-${var.region}-${var.environment}-password"
  shared_image_gallery_name     = "sig${var.app}${var.region}${var.environment}"
}
