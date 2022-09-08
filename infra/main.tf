terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.21.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-webDataQueue-ussc-dev"
    storage_account_name = "sawebdataqueuetfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    #access_key = $env:ARM_ACCESS_KEY
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}

module "services" {
  source                         = "./modules/services"
  resource_group_name            = var.resource_group_name
  app                            = var.app
  region                         = var.region
  environment                    = var.environment
  location                       = var.location
  resource_tags                  = var.resource_tags
  vm_queue_username_secret_value = var.vm_queue_username_secret_value
  vm_queue_password_secret_value = var.vm_queue_password_secret_value
  admin_upn                      = var.admin_upn
  sql_username_secret_value      = var.sql_username_secret_value
  sql_password_secret_value      = var.sql_password_secret_value
}

module "network" {
  source = "./modules/network"
  depends_on = [
    module.services
  ]
  resource_group_name   = var.resource_group_name
  location              = var.location
  app                   = var.app
  region                = var.region
  environment           = var.environment
  resource_tags         = var.resource_tags
  private_dns_zone_name = module.services.private_dns_zone_name
}

module "app" {
  source = "./modules/app"
  depends_on = [
    module.services,
    module.network
  ]
  resource_group_name           = var.resource_group_name
  location                      = var.location
  app                           = var.app
  region                        = var.region
  environment                   = var.environment
  resource_tags                 = var.resource_tags
  vnet_name                     = module.network.vnet_name
  vnet_app_internal_subnet_name = module.network.vnet_app_internal_subnet_name
  vnet_app_external_subnet_name = module.network.vnet_app_external_subnet_name
  vnet_app_queue_subnet_name    = module.network.vnet_app_queue_subnet_name
  log_analytics_workspace_name  = module.services.log_analytics_workspace_name
  application_insights_name     = module.services.application_insights_name
  key_vault_name                = module.services.key_vault_name
  private_dns_zone_name         = module.services.private_dns_zone_name
  user_assigned_identity_name   = module.services.user_assigned_identity_name
  vm_queue_username_secret_name = module.services.vm_queue_username_secret_name
  vm_queue_password_secret_name = module.services.vm_queue_password_secret_name
  sql_username_secret_name      = module.services.sql_username_secret_name
  sql_password_secret_name      = module.services.sql_password_secret_name
}

module "data" {
  source = "./modules/data"
  depends_on = [
    module.services,
    module.network
  ]
  resource_group_name          = var.resource_group_name
  location                     = var.location
  app                          = var.app
  region                       = var.region
  environment                  = var.environment
  resource_tags                = var.resource_tags
  vnet_name                    = module.network.vnet_name
  vnet_data_subnet_name        = module.network.vnet_data_subnet_name
  log_analytics_workspace_name = module.services.log_analytics_workspace_name
  application_insights_name    = module.services.application_insights_name
  key_vault_name               = module.services.key_vault_name
  user_assigned_identity_name  = module.services.user_assigned_identity_name
  admin_upn                    = var.admin_upn
  sql_username_secret_name     = module.services.sql_username_secret_name
  sql_password_secret_name     = module.services.sql_password_secret_name
}
