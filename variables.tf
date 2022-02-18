#Global Variables
variable "globals" {
  description = "Global variables for the resource deployment: deployment_code, owner_tag"
  type = object({
    deployment_code = string
    owner_tag       = string
  })

  validation {
    condition     = length(var.globals.deployment_code) == 4
    error_message = "Application code must be a 4 letters string."
  }
}

variable "az_rg_name" {
  description = "Specifies the resource group name where resources will be deployed"
  type        = string
}

variable "region_code" {
  description = "Specifies the region code for the resource deployment"
  type        = string
}

variable "az_sequential" {
  description = "Specifies the region code for the resource deployment"
  type        = string
  default     = "01"
}

#Private variables
variable "vnet_address_space" {
  description = "Specifies the address space for the vnet"
  type        = list(string)

  validation {
    condition     = length(var.vnet_address_space) == 1
    error_message = "Vnet must have a 1 address space."
  }
}

variable "snet_address_prefix" {
  description = "Specifies the address prefixes for the subnets"
  type        = list(string)

  validation {
    condition     = length(var.snet_address_prefix) == 2
    error_message = "Subnet must have a 2 address prefixes."
  }
}

variable "az_stg_containers" {
  description = "Specifies the name of containers for the storage account"
  type        = list(string)

  validation {
    condition     = length(var.az_stg_containers) > 0
    error_message = "At leats 1 container must be specified."
  }
}

variable "whitelisted_ips" {
  description = "Specifies the safe ip list"
  type        = list(string)

  validation {
    condition     = length(var.whitelisted_ips) > 0
    error_message = "At leats 1 ip must be specified."
  }
}

#Local variables
locals {
  az_location = {
    eus1 = "eastus"
    eus2 = "eastus2"
    cnus = "centralus"
    wsus = "westus"
  }
}
