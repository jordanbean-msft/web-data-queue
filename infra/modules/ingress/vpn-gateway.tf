resource "azurerm_public_ip" "vpn_gateway_public_ip" {
  name                = local.vpn_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = local.vpn_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "VpnGw2"
  type                = "Vpn"
  vpn_type            = "RouteBased"
  ip_configuration {
    name                          = "vpn-gateway-ip-configuration"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway_public_ip.id
    subnet_id                     = data.azurerm_subnet.vnet_vpn_gateway_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  vpn_client_configuration {
    address_space        = var.vpn_gateway_client_configuration_address_space
    vpn_auth_types       = ["AAD"]
    aad_tenant           = "https://login.microsoftonline.com/${data.azurerm_client_config.client_config.tenant_id}/"
    aad_issuer           = "https://sts.windows.net/${data.azurerm_client_config.client_config.tenant_id}/"
    aad_audience         = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    vpn_client_protocols = ["OpenVPN"]
  }
}
