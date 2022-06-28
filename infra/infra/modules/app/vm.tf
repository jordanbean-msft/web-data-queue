resource "azurerm_network_interface" "vm_queue_nic" {
  name                = local.vm_queue_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.app_queue_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm_queue" {
  name                  = local.vm_queue_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = "Standard_D2_v3"
  network_interface_ids = [azurerm_network_interface.vm_queue_nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  admin_username = data.azurerm_key_vault_secret.vm_queue_username_secret.value
  admin_password = data.azurerm_key_vault_secret.vm_queue_password_secret.value
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      admin_password,
      admin_username,
    ]
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_queue_shutdown" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm_queue.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = "1800"
  timezone              = "Central Standard Time"

  notification_settings {
    enabled = false
  }
}

# resource "azurerm_monitor_diagnostic_setting" "vm_queue_diagnostic_settings" {
#   name                       = "logging"
#   target_resource_id         = azurerm_windows_web_app.admin_portal.id
#   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
#   log {
#     category = "AppServiceHTTPLogs"
#     enabled  = true
#   }
#   log {
#     category = "AppServiceConsoleLogs"
#     enabled  = true
#   }
#   log {
#     category = "AppServiceAppLogs"
#     enabled  = true
#   }
#   log {
#     category = "AppServiceAuditLogs"
#     enabled  = true
#   }
#   log {
#     category = "AppServiceIPSecAuditLogs"
#     enabled  = true
#   }
#   log {
#     category = "AppServicePlatformLogs"
#     enabled  = true
#   }
#   metric {
#     category = "AllMetrics"
#     enabled  = true
#   }
# }
