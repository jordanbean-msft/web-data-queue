output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_app_subnet_name" {
  value = azurerm_subnet.app_subnet.name
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
