#!/bin/bash

set -e

resource_group_name=mgdapppoc1
storage_account_name=mgdapppoc1
blob_container_name=appdef
appdef_package_name=foom

# Zip
(cd demoappdef/package; zip ../../appdef-package.zip -r .)

# Upload
az storage blob upload --account-name "$storage_account_name" --container-name "$blob_container_name" -n "${appdef_package_name}appdef.zip" -f appdef-package.zip --only-show-errors

# Get blob URI and print for use in application definition
url="$(az storage blob url --account-name "$storage_account_name" --container-name "$blob_container_name" -n "${appdef_package_name}appdef.zip" --only-show-errors -o tsv)"
echo "$url"
