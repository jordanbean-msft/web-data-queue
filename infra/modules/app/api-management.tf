resource "azurerm_api_management" "api_management" {
  name                 = local.api_management_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  publisher_name       = var.api_management_publisher_name
  publisher_email      = var.api_management_publisher_email
  sku_name             = var.api_management_sku
  virtual_network_type = "Internal"
  virtual_network_configuration {
    subnet_id = data.azurerm_subnet.vnet_api_management_subnet.id
  }
}
