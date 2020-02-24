
output resource_group {
  value = azurerm_resource_group.global.name
}

output ARM_CLIENT_SECRET {
  value     = azuread_service_principal_password.sp.value
  sensitive = true
}

output ARM_CLIENT_ID {
  value = azuread_service_principal.sp.application_id
}

output ARM_TENANT_ID {
  value = data.azurerm_subscription.primary.tenant_id
}

output ARM_SUBSCRIPTION_ID {
  value = data.azurerm_subscription.primary.subscription_id
}


output storage_account_name {
  value = azurerm_storage_account.primary.name
}

output storage_container_name {
  value = azurerm_storage_container.primary.name
}

output ARM_ACCESS_KEY {
  value     = azurerm_storage_account.primary.primary_access_key
  sensitive = true
}
