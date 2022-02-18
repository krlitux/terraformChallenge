#!/usr/bin/env bash

az storage blob upload \
	--account-name $storageAccountName \
	--account-key $accountPrimaryAccessKey \
	--container-name $accountContainer \
	--file "$path/terraform.tfstate" \
	--name "$path/terraform.tfstate"
