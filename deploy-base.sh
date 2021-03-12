#!/bin/bash

set -e

resource_group_name=mgdapppoc1
storage_account_name=mgdapppoc1
blob_container_name=appdef

az storage account create -g "$resource_group_name" -n "$storage_account_name" -l australiaeast --sku Standard_LRS

az storage container create --account-name "$storage_account_name" -n "$blob_container_name" --only-show-errors
