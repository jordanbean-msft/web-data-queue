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
variable "admin_upn" {
  sensitive = true
}
