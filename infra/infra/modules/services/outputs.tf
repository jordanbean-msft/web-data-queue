output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.name
}
output "application_insights_name" {
  value = azurerm_application_insights.application_insights.name
}
output "key_vault_name" {
  value = azurerm_key_vault.key_vault.name
}
output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.private_dns_zone.name
}
output "user_assigned_identity_name" {
  value = azurerm_user_assigned_identity.user_assigned_identity.name
}
output "vm_queue_username_secret_name" {
  value = azurerm_key_vault_secret.vm_queue_username_secret.name
}
output "vm_queue_password_secret_name" {
  value = azurerm_key_vault_secret.vm_queue_password_secret.name
}
