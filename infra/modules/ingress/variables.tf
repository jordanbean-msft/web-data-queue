variable "resource_group_name" {}
variable "location" {}
variable "app" {}
variable "region" {}
variable "environment" {}
variable "resource_tags" {
  type = map(any)
}
variable "vnet_name" {}
variable "vnet_vpn_gateway_subnet_name" {}
variable "vpn_gateway_client_configuration_address_space" {}

locals {
  vpn_gateway_name             = "vpn-${var.app}-${var.region}-${var.environment}"
  vpn_gateway_public_ip_name   = "pip-vpn-${var.app}-${var.region}-${var.environment}"
  load_balancer_public_ip_name = "pip-lb-${var.app}-${var.region}-${var.environment}"
  load_balancer_name           = "lb-${var.app}-${var.region}-${var.environment}"
}
