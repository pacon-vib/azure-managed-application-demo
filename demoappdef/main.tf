variable "application_definition_name" {
  default = "foom"
}

variable "application_definition_package_uri" {
  # Update from output of `release-appdef-package.sh`
  default = "https://mgdapppoc1.blob.core.windows.net/appdef/foomappdef.zip" 
}

resource "azurerm_resource_group" "module" {
  name     = "${var.application_definition_name}-def-rg"
  location = "Australia East"
}

data "azurerm_client_config" "current" {}

data "azurerm_role_definition" "owner" {
  name = "Owner"
}

locals {
  owner_role_definition_guid = regex("^/.*/(.*)$", data.azurerm_role_definition.owner.id)[0]
}

resource "azurerm_managed_application_definition" "module" {
  name                = var.application_definition_name
  location            = azurerm_resource_group.module.location
  resource_group_name = azurerm_resource_group.module.name
  lock_level          = "ReadOnly"
  package_file_uri    = var.application_definition_package_uri
  display_name        = "The Foo Manager"
  description         = "Managed application for managing foos"

  authorization {
    service_principal_id = data.azurerm_client_config.current.object_id
    role_definition_id   = local.owner_role_definition_guid
  }
}

output "application_definition_id" {
  description = "Fully-qualified ARM ID of managed application definition"
  value       = azurerm_managed_application_definition.module.id
}
