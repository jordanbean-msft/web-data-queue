data "azurerm_client_config" "current" {}

data "azuread_user" "admin" {
  user_principal_name = var.admin_upn
}
