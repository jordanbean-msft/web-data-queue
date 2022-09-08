resource "azurerm_shared_image_gallery" "shared_image_gallery" {
  name = local.shared_image_gallery_name
  location = var.location
  resource_group_name = var.resource_group_name
}