output "stgacc_name" {
  description = "Deployed storage account name"
  value       = azurerm_storage_account.azStorage.name
}

output "primaryAccessKey" {
  description = "Access Key from storage account"
  value       = azurerm_storage_account.azStorage.primary_access_key
}

output "accountContainer" {
  description = "Storage account container names"
  value       = { for index in keys(azurerm_storage_container.azStorage) : index => azurerm_storage_container.azStorage[index].name }
}
