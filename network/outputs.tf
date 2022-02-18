output "subnet_id" {
  description = "Deployed subnet id"
  value       = { for index in keys(azurerm_subnet.azNetwork) : index => azurerm_subnet.azNetwork[index].id }
}