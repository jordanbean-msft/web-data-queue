resource "azurerm_mssql_managed_instance" "managed_instance" {
  name                         = local.sql_server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  license_type                 = "LicenseIncluded"
  sku_name                     = "GP_Gen5"
  storage_size_in_gb           = "32"
  subnet_id                    = data.azurerm_subnet.data_subnet.id
  vcores                       = 4
  administrator_login          = data.azurerm_key_vault_secret.sql_username_secret.value
  administrator_login_password = data.azurerm_key_vault_secret.sql_password_secret.value
  storage_account_type         = "LRS"
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      subnet_id,
      administrator_login,
      administrator_login_password
    ]
  }
}

# resource "azurerm_mssql_managed_instance_active_directory_administrator" "managed_instance_aad_administrator" {
#   managed_instance_id = azurerm_mssql_managed_instance.managed_instance.id
#   login_username      = data.azuread_user.admin.user_principal_name
#   object_id           = data.azuread_user.admin.object_id
#   tenant_id           = data.azurerm_client_config.current.tenant_id
# }

resource "azurerm_monitor_diagnostic_setting" "managed_instance_diagnostic_settings" {
  name                       = "logging"
  target_resource_id         = azurerm_mssql_managed_instance.managed_instance.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  log {
    category = "ResourceUsageStats"
    enabled  = true
  }
}

resource "azurerm_mssql_managed_database" "web_portal_db" {
  name                = local.sql_web_portal_db_name
  managed_instance_id = azurerm_mssql_managed_instance.managed_instance.id
}

resource "azurerm_monitor_diagnostic_setting" "web_portal_db_diagnostic_settings" {
  name                       = "logging"
  target_resource_id         = azurerm_mssql_managed_database.web_portal_db.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  log {
    category = "SQLInsights"
    enabled  = true
  }
  log {
    category = "QueryStoreRuntimeStatistics"
    enabled  = true
  }
  log {
    category = "QueryStoreWaitStatistics"
    enabled  = true
  }
  log {
    category = "Errors"
    enabled  = true
  }
}

resource "azurerm_mssql_managed_database" "admin_portal_db" {
  name                = local.sql_admin_portal_db_name
  managed_instance_id = azurerm_mssql_managed_instance.managed_instance.id
}

resource "azurerm_monitor_diagnostic_setting" "admin_portal_db_diagnostic_settings" {
  name                       = "logging"
  target_resource_id         = azurerm_mssql_managed_database.admin_portal_db.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  log {
    category = "SQLInsights"
    enabled  = true
  }
  log {
    category = "QueryStoreRuntimeStatistics"
    enabled  = true
  }
  log {
    category = "QueryStoreWaitStatistics"
    enabled  = true
  }
  log {
    category = "Errors"
    enabled  = true
  }
}
