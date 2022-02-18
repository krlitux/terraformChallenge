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
variable "az_subnet_id" {
  description = "Specifies the id for the subnet"
  type        = map(string)
}

variable "az_stg_containers" {
  description = "Specifies the list of storage containers"
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

  stg_code              = "stgacc"
  stgacc_name           = format("%s%s%s%s", local.stg_code, lower(var.region_code), lower(var.globals.deployment_code), var.az_sequential)
  container_access_type = "blob"

  stg_container_map = {
    for index in range(length(var.az_stg_containers)) : index => {
      container_name = var.az_stg_containers[index]
    }
  }
}
