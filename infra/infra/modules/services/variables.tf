variable "resource_group_name" {}
variable "location" {}
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

locals {
  log_analytics_workspace_name  = "la-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  application_insights_name     = "ai-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  key_vault_name                = "kv-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  private_dns_zone_name         = "${var.resource_tags.environment}.${var.resource_tags.region}.${var.resource_tags.app}"
  user_assigned_identity_name   = "mi-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  vm_queue_username_secret_name = "vmQueue${var.resource_tags.app}${var.resource_tags.region}${var.resource_tags.environment}-username"
  vm_queue_password_secret_name = "vmQueue${var.resource_tags.app}${var.resource_tags.region}${var.resource_tags.environment}-password"
  sql_username_secret_name      = "sqls-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}-username"
  sql_password_secret_name      = "sqls-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}-password"
  shared_image_gallery_name     = "sig${var.resource_tags.app}${var.resource_tags.region}${var.resource_tags.environment}"
}
