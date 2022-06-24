terraform {
  source = "../..//infra"
}

inputs = {
  resource_tags = {
    app         = "webDataQueue"
    region      = "ussc"
    environment = "dev"
  }

  location = "South Central US"

  resource_group_name = "rg-webDataQueue-ussc-dev"
}