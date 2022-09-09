resource "azurerm_public_ip" "load_balancer_public_ip" {
  name                = local.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load_balancer" {
  name                = local.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.load_balancer_public_ip.id
  }
}
