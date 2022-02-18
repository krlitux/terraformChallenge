globals = {
  deployment_code = "trfm"
  owner_tag       = "Carlos Vasquez"
}

az_rg_name          = "terraform_demo01"
region_code         = "eus2"
az_sequential       = "06"
vnet_address_space  = ["10.0.0.0/16"]
snet_address_prefix = ["10.0.0.0/24", "10.0.1.0/24"]
az_stg_containers   = ["demo01", "demo02", "demo03", "demo04"]
whitelisted_ips     = ["1.1.1.1"]
