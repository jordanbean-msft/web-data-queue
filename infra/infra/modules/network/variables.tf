variable "resource_group_name" {}
variable "location" {}
variable "resource_tags" {
  type = map(any)
}
variable "private_dns_zone_name" {}

locals {
  vnet_name                                     = "vnet-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  vnet_address_prefix                           = "10.0.0.0/16"
  vnet_app_subnet_name                          = "application"
  vnet_app_subnet_address_prefix                = "10.0.0.0/27"
  vnet_app_subnet_network_security_group_name   = "nsg-app-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  vnet_data_subnet_name                         = "data"
  vnet_data_subnet_address_prefix               = "10.0.1.0/24"
  vnet_data_subnet_network_security_group_name  = "nsg-data-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
  vnet_vpn_gateway_subnet_name                  = "GatewaySubnet"
  vnet_vpn_gateway_subnet_address_prefix        = "10.0.2.0/27"
  vnet_build_subnet_name                        = "build"
  vnet_build_subnet_address_prefix              = "10.0.3.0/27"
  vnet_build_subnet_network_security_group_name = "nsg-build-${var.resource_tags.app}-${var.resource_tags.region}-${var.resource_tags.environment}"
}
