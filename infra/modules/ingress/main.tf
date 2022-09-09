data "azurerm_subnet" "vnet_vpn_gateway_subnet" {
  name                 = var.vnet_vpn_gateway_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_client_config" "client_config" {
}
