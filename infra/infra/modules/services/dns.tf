resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = local.private_dns_zone_name
  resource_group_name = var.resource_group_name
}
