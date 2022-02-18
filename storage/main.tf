resource "azurerm_storage_account" "azStorage" {
  name                = local.stgacc_name
  resource_group_name = var.az_rg_name

  location                 = local.az_location[var.region_code]
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  network_rules {
    bypass         = ["None"]
    default_action = "Deny"
    ip_rules       = var.whitelisted_ips
  }

  tags = {
    owner = var.globals.owner_tag
  }
}

resource "azurerm_storage_container" "azStorage" {
  for_each = local.stg_container_map

  name                  = each.value.container_name
  storage_account_name  = azurerm_storage_account.azStorage.name
  container_access_type = local.container_access_type
}

resource "azurerm_private_endpoint" "azStorage" {
  location            = azurerm_storage_account.azStorage.location
  name                = azurerm_storage_account.azStorage.name
  resource_group_name = azurerm_storage_account.azStorage.resource_group_name
  subnet_id           = var.az_subnet_id[1]

  private_service_connection {
    is_manual_connection           = false
    name                           = azurerm_storage_account.azStorage.name
    private_connection_resource_id = azurerm_storage_account.azStorage.id
    subresource_names              = ["blob"]
  }

  tags = {
    owner = var.globals.owner_tag
  }

  timeouts {}
}
