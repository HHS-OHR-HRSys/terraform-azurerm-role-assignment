locals {
    # Use try() to handle the case when principal_ids contains values that can't be determined yet
    # If it fails, default to an empty set
    principals = try(toset(var.principal_ids), toset([]))
}

resource "azurerm_role_assignment" "role_assignment" {
    for_each = local.principals
    
    scope                            = var.scope_id
    role_definition_name             = var.role_definition_name
    principal_id                     = each.key
    skip_service_principal_aad_check = var.skip_service_principal_aad_check
}
