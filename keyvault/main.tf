resource "azurerm_key_vault" "azKeyvault" {
  name                        = local.kvault_name
  location                    = local.az_location[var.region_code]
  resource_group_name         = var.az_rg_name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 30
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    bypass         = "None"
    default_action = "Deny"
    ip_rules       = var.whitelisted_ips
  }

  tags = {
    owner = var.globals.owner_tag
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_private_endpoint" "azKeyvault" {
  location            = azurerm_key_vault.azKeyvault.location
  name                = azurerm_key_vault.azKeyvault.name
  resource_group_name = azurerm_key_vault.azKeyvault.resource_group_name
  subnet_id           = var.az_subnet_id[0]

  private_service_connection {
    is_manual_connection           = false
    name                           = azurerm_key_vault.azKeyvault.name
    private_connection_resource_id = azurerm_key_vault.azKeyvault.id
    subresource_names              = ["vault"]
  }

  tags = {
    owner = var.globals.owner_tag
  }

  timeouts {}
}
