resource "azurerm_route_table" "data_route_table" {
  name                = local.vnet_data_subnet_route_table
  location            = var.location
  resource_group_name = var.resource_group_name
  route               = []
}
