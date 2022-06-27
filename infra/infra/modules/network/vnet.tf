resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["${local.vnet_address_prefix}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "vnet_link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_subnet" "app_internal_subnet" {
  name                 = local.vnet_app_internal_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_app_internal_subnet_address_prefix]
  delegation {
    name = "appServiceDelegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "app_internal_subnet_nsg" {
  subnet_id                 = azurerm_subnet.app_internal_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_subnet" "app_external_subnet" {
  name                 = local.vnet_app_external_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_app_external_subnet_address_prefix]
  delegation {
    name = "appServiceDelegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "app_external_subnet_nsg" {
  subnet_id                 = azurerm_subnet.app_external_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_subnet" "app_queue_subnet" {
  name                 = local.vnet_app_queue_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_app_queue_subnet_address_prefix]
}

resource "azurerm_subnet_network_security_group_association" "app_queue_subnet_nsg" {
  subnet_id                 = azurerm_subnet.app_queue_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_subnet" "data_subnet" {
  name                 = local.vnet_data_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vnet_data_subnet_address_prefix]
  delegation {
    name = "managedInstanceDelegation"
    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "data_subnet_nsg" {
  subnet_id                 = azurerm_subnet.data_subnet.id
  network_security_group_id = azurerm_network_security_group.data_nsg.id
}

resource "azurerm_subnet_route_table_association" "data_subnet_route_table" {
  subnet_id      = azurerm_subnet.data_subnet.id
  route_table_id = azurerm_route_table.data_route_table.id
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
