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
}

variable "snet_address_prefix" {
  description = "Specifies the address prefix for the subnet"
  type        = list(string)
}

variable "whitelisted_ips" {
  description = "Specifies the safe ip list"
  type        = list(string)
}

#Local variables
locals {
  az_location = {
    eus1 = "eastus"
    eus2 = "eastus2"
    cnus = "centralus"
    wsus = "westus"
  }

  vnet_code = "virtnet"
  snet_code = "subnet"
  vnet_name = format("%s%s%s%s", local.vnet_code, lower(var.region_code), lower(var.globals.deployment_code), var.az_sequential)
  snet_name = format("%s%s%s", local.snet_code, lower(var.region_code), lower(var.globals.deployment_code))
  snet_seq  = length(var.snet_address_prefix) < 9 ? "0" : ""

  snet_map = {
    for index in range(length(var.snet_address_prefix)) : index => {
      subnet_prefix = [element(var.snet_address_prefix, index)]
      subnet_name   = format("%s%s%s", local.snet_name, local.snet_seq, index + 1)
    }
  }

}
