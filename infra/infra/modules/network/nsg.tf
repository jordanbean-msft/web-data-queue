resource "azurerm_network_security_group" "app_nsg" {
  name                = local.vnet_app_subnet_network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "data_nsg" {
  name                = local.vnet_data_subnet_network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "build_nsg" {
  name                = local.vnet_build_subnet_network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
