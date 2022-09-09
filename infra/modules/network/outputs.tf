output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_app_internal_subnet_name" {
  value = azurerm_subnet.app_internal_subnet.name
}

output "vnet_app_external_subnet_name" {
  value = azurerm_subnet.app_external_subnet.name
}

output "vnet_app_queue_subnet_name" {
  value = azurerm_subnet.app_queue_subnet.name
}

output "vnet_data_subnet_name" {
  value = azurerm_subnet.data_subnet.name
}

output "vnet_vpn_gateway_subnet_name" {
  value = azurerm_subnet.vpn_gateway_subnet.name
}

output "vnet_build_subnet_name" {
  value = azurerm_subnet.build_subnet.name
}

output "vnet_api_management_subnet_name" {
  value = azurerm_subnet.api_management_subnet.name
}
