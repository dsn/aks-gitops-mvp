data "azurerm_subscription" "primary" {
}

# Create an application
resource "azuread_application" "servicePrincipalApp" {
  name = "${var.prefix}App"
}

# Create a service principal
resource "azuread_service_principal" "sp" {
  application_id = azuread_application.servicePrincipalApp.application_id
}

resource "random_uuid" "sp_password" {}

resource "azuread_service_principal_password" "sp" {
  service_principal_id = azuread_service_principal.sp.id
  value                = random_uuid.sp_password.result
  end_date             = var.principal_password_enddate
}

resource "azurerm_role_definition" "role" {
  name        = "${var.prefix}-sp-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a role for ${var.prefix} created with terraform"

  permissions {
    actions     = ["*"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

resource "azurerm_role_assignment" "global" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.role.id
  principal_id       = azuread_service_principal.sp.id
}

