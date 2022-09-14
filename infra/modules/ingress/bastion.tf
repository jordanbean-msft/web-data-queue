resource "azurerm_public_ip" "bastion_public_ip" {
  name                = local.bastion_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.vnet_bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }

  lifecycle {
    ignore_changes = [
      ip_configuration[0].subnet_id,
    ]
  }
}
