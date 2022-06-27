output "app_service_web_portal_name" {
  value = azurerm_windows_web_app.web_portal.name
}

output "app_service_admin_portal_name" {
  value = azurerm_windows_web_app.admin_portal.name
}
