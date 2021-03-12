variable "application_definition_id" {
  description = "Fully-qualified ARM ID of managed application definition"
}

variable "application_instance_name" {
  default = "patfoom"
}

resource "azurerm_resource_group" "module" {
  name     = var.application_instance_name
  location = "Australia East"
}

resource "random_string" "storage_account_suffix" {
  length  = 24 - length(var.application_instance_name)
  special = false
  upper   = false
}

locals {
  managed_resource_group_name  = "${var.application_instance_name}-res"
  managed_storage_account_name = "${var.application_instance_name}${random_string.storage_account_suffix.result}"
}

resource "azurerm_managed_application" "module" {
  name                        = var.application_instance_name
  location                    = azurerm_resource_group.module.location
  resource_group_name         = azurerm_resource_group.module.name
  kind                        = "ServiceCatalog"
  managed_resource_group_name = local.managed_resource_group_name
  application_definition_id   = var.application_definition_id

  parameters = {
    location             = azurerm_resource_group.module.location
    storageName = local.managed_storage_account_name
  }
}
