resource "azurerm_storage_account" "storage_account" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                 = local.storage_account_img_container_name
  storage_account_name = azurerm_storage_account.storage_account.name
}

data "azurerm_monitor_diagnostic_categories" "storage" {
  resource_id = azurerm_storage_account.storage_account.id
}

resource "azurerm_monitor_diagnostic_setting" "storage" {
  name                       = "storageladiagnostics"
  target_resource_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}

data "azurerm_monitor_diagnostic_categories" "storage_blob" {
  resource_id = "${azurerm_storage_account.storage_account.id}/blobServices/default/"
}

resource "azurerm_monitor_diagnostic_setting" "storage_blob" {
  name                       = "storageblobladiagnostics"
  target_resource_id         = "${azurerm_storage_account.storage_account.id}/blobServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_blob.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_blob.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}
