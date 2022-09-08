variable "resource_group_name" {}
variable "location" {}
variable "subscription_id" {}
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
