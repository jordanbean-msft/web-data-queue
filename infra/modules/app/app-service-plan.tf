resource "azurerm_service_plan" "app_service_plan_internal" {
  name                = local.app_service_plan_internal_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "P1v2"
}
resource "azurerm_service_plan" "app_service_plan_external" {
  name                = local.app_service_plan_external_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "P1v2"
}
