resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["${local.vnet_address_prefix}"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = local.vnet_app_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_app_subnet_address_prefix]
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_subnet" "data_subnet" {
  name                 = local.vnet_data_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_data_subnet_address_prefix]
}

resource "azurerm_subnet_network_security_group_association" "data_subnet_nsg" {
  subnet_id                 = azurerm_subnet.data_subnet.id
  network_security_group_id = azurerm_network_security_group.data_nsg.id
}

resource "azurerm_subnet" "vpn_gateway_subnet" {
  name                 = local.vnet_vpn_gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_vpn_gateway_subnet_address_prefix]
}

resource "azurerm_subnet" "build_subnet" {
  name                 = local.vnet_build_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_build_subnet_address_prefix]
}

resource "azurerm_subnet_network_security_group_association" "build_subnet_nsg" {
  subnet_id                 = azurerm_subnet.build_subnet.id
  network_security_group_id = azurerm_network_security_group.build_nsg.id
}
