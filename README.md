# terraformChallenge

## **Deployed Resources**
* 01 Virtual network
* 02 Subnets
* 02 Network security group
* 02 Private endpoint
* 01 Storage Account
* 01 Keyvault

## **Instructions**

### **Step 01**
From a Linux console, authenticate to an azure subscription with the "az login" command
### **Step 02**
Edit the terraform.tfvars file according to the following table

| Variable name | Required | Description | Type | Allowed values | Default 
| --------------- | :-------: | ----------- | ------------- | ------------------ | ----------------- |
| globals | Yes | Global variables for the resource deployment: deployment_code, owner_tag | String | deployment_code is limited to a length of 4 characters | - | 
| region_code | Yes | Specifies the Azure region code where resources will be deployed | String | "wsus","eus1","eus2","cnus" | - | 
| az_sequential  | No | Specifies the correlative for the deployment of the resource | String | Examples: "01", "02", ... | "01" | 
| az_rg_name   | Yes | Specifies the resource group name where resources will be deployed | String | Examples: "test_resource_group" | - |
| vnet_address_space  | Yes | Specifies the address space for the vnet | String | Examples: "10.0.0.0/16", "10.1.0.0/16", ... | - |
| snet_address_prefix   | Yes | Specifies the address prefixes for the subnets | List(String) | Limited to a length of 2 items: ["10.0.0.0/24", "10.0.1.0/24"] | - |
| az_stg_containers  | Yes | Specifies the name of containers for the storage account | List(String) | Examples: ["demo01", "demo02"] | - |
| whitelisted_ips  | Yes | Specifies the list of safe ip | List(String) | Examples: ["1.1.1.1"] | - |

### **Step 03**
From a Linux console, execute the "terraform apply" command
