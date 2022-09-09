data "azurerm_client_config" "current" {}

data "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.user_assigned_identity_name
  resource_group_name = var.resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "app_internal_subnet" {
  name                 = var.vnet_app_internal_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}

data "azurerm_subnet" "app_external_subnet" {
  name                 = var.vnet_app_external_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}

data "azurerm_subnet" "app_queue_subnet" {
  name                 = var.vnet_app_queue_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}

data "azurerm_key_vault_secret" "vm_queue_username_secret" {
  name         = var.vm_queue_username_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "vm_queue_password_secret" {
  name         = var.vm_queue_password_secret_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_subnet" "vnet_api_management_subnet" {
  name                 = var.vnet_api_management_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}
