#region Library Variable Sets

# This section captures the details of space level resources in a library variable set. This allows things like
# accounts, feeds, certificates etc to be recreated with octoterra.
# Note these variables are not consumed by the "regular" runbooks or deployment steps.

data "octopusdeploy_library_variable_sets" "space_resource_secrets" {
  partial_name = "Octopus Space Resources"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_library_variable_set" "octopus_library_variable_set" {
  count       = length(data.octopusdeploy_library_variable_sets.space_resource_secrets.library_variable_sets) == 0 ? 1 : 0
  name        = "Octopus Space Resources"
  description = "The details of space level resources, used when recreating the space with octoterra"
}
#endregion
