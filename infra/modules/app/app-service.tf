resource "azurerm_windows_web_app" "web_portal" {
  name                = local.app_service_web_portal_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_service_plan_external.id
  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
  }
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = data.azurerm_application_insights.application_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = data.azurerm_application_insights.application_insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    "XDT_MicrosoftApplicationInsights_Mode"      = "Recommended"
    "MESSAGE"                                    = "Bears, beets, battlestar galactica"
    "SQL_DATABASE_USERNAME"                      = "@Microsoft.KeyVault(VaultName=${var.key_vault_name};SecretName=${var.sql_username_secret_name})"
  }
  key_vault_reference_identity_id = data.azurerm_user_assigned_identity.user_assigned_identity.id
  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.user_assigned_identity.id]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_web_portal_vnet_integration" {
  app_service_id = azurerm_windows_web_app.web_portal.id
  subnet_id      = data.azurerm_subnet.app_external_subnet.id
}

resource "azurerm_monitor_diagnostic_setting" "web_portal_diagnostic_settings" {
  name                       = "logging"
  target_resource_id         = azurerm_windows_web_app.web_portal.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }
  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
  }
  log {
    category = "AppServiceAppLogs"
    enabled  = true
  }
  log {
    category = "AppServiceAuditLogs"
    enabled  = true
  }
  log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = true
  }
  log {
    category = "AppServicePlatformLogs"
    enabled  = true
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_windows_web_app" "admin_portal" {
  name                = local.app_service_admin_portal_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_service_plan_internal.id
  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
  }
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = data.azurerm_application_insights.application_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = data.azurerm_application_insights.application_insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    "XDT_MicrosoftApplicationInsights_Mode"      = "Recommended"
  }
  key_vault_reference_identity_id = data.azurerm_user_assigned_identity.user_assigned_identity.id
  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.user_assigned_identity.id]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_admin_portal_vnet_integration" {
  app_service_id = azurerm_windows_web_app.admin_portal.id
  subnet_id      = data.azurerm_subnet.app_internal_subnet.id
}

resource "azurerm_monitor_diagnostic_setting" "admin_portal_diagnostic_settings" {
  name                       = "logging"
  target_resource_id         = azurerm_windows_web_app.admin_portal.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }
  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
  }
  log {
    category = "AppServiceAppLogs"
    enabled  = true
  }
  log {
    category = "AppServiceAuditLogs"
    enabled  = true
  }
  log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = true
  }
  log {
    category = "AppServicePlatformLogs"
    enabled  = true
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
