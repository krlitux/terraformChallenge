resource "azurerm_virtual_network" "azNetwork" {
  name                = local.vnet_name
  address_space       = var.vnet_address_space
  location            = local.az_location[var.region_code]
  resource_group_name = var.az_rg_name

  tags = {
    owner = var.globals.owner_tag
  }
}

resource "azurerm_subnet" "azNetwork" {
  for_each                                       = local.snet_map
  name                                           = each.value.subnet_name
  resource_group_name                            = azurerm_virtual_network.azNetwork.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.azNetwork.name
  address_prefixes                               = each.value.subnet_prefix
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_network_security_group" "azNetwork" {
  for_each            = azurerm_subnet.azNetwork
  name                = each.value.name
  location            = local.az_location[var.region_code]
  resource_group_name = each.value.resource_group_name
  tags = {
    owner = var.globals.owner_tag
  }
}

resource "azurerm_subnet_network_security_group_association" "azNetwork" {
  for_each                  = azurerm_network_security_group.azNetwork
  subnet_id                 = azurerm_subnet.azNetwork[each.key].id
  network_security_group_id = each.value.id
}
