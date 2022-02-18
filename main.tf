#Terraform provider
provider "azurerm" {
  features {}
}

#Resource group
resource "azurerm_resource_group" "azTerra" {
  name     = var.az_rg_name
  location = local.az_location[var.region_code]
  tags = {
    owner = var.globals.owner_tag
  }
}

#Network module
module "azNetwork" {
  source = "./network"

  globals             = var.globals
  az_sequential       = var.az_sequential
  az_rg_name          = azurerm_resource_group.azTerra.name
  region_code         = var.region_code
  vnet_address_space  = var.vnet_address_space
  snet_address_prefix = var.snet_address_prefix
  whitelisted_ips     = var.whitelisted_ips
}

#keyvault module
module "azKeyvault" {
  source = "./keyvault"

  globals       = var.globals
  az_sequential = var.az_sequential
  az_rg_name    = azurerm_resource_group.azTerra.name
  region_code   = var.region_code
  az_subnet_id  = module.azNetwork.subnet_id
  whitelisted_ips     = var.whitelisted_ips
}

#storage module
module "azStorage" {
  source = "./storage"

  globals           = var.globals
  az_sequential     = var.az_sequential
  az_rg_name        = azurerm_resource_group.azTerra.name
  region_code       = var.region_code
  az_subnet_id      = module.azNetwork.subnet_id
  az_stg_containers = var.az_stg_containers
  whitelisted_ips     = var.whitelisted_ips
}

/* Move tfState to Storage */
