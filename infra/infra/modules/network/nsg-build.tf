resource "azurerm_network_security_group" "build_nsg" {
  name                = local.vnet_build_subnet_network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
