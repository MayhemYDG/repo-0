#region Library Variable Sets

# This section captures the details of space level resources in a library variable set. This allows things like
# accounts, feeds, certificates etc to be recreated with octoterra.
# Note these variables are not consumed by the "regular" runbooks or deployment steps.

data "octopusdeploy_library_variable_sets" "this_instance" {
  partial_name = "This Instance"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_library_variable_set" "this_instance" {
  count       = length(data.octopusdeploy_library_variable_sets.this_instance.library_variable_sets) == 0 ? 1 : 0
  name        = "This Instance"
  description = "Credentials used to interact with this Octopus instance"
}

resource "octopusdeploy_variable" "octopus_admin_api_key" {
  count           = length(data.octopusdeploy_library_variable_sets.this_instance.library_variable_sets) == 0 ? 1 : 0
  name            = "Octopus.ApiKey"
  type            = "Sensitive"
  description     = "Octopus API Key"
  is_sensitive    = true
  is_editable     = true
  owner_id        = octopusdeploy_library_variable_set.this_instance[0].id
  sensitive_value = var.octopus_apikey
}

data "octopusdeploy_library_variable_sets" "docker" {
  partial_name = "Docker"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_library_variable_set" "docker" {
  count       = length(data.octopusdeploy_library_variable_sets.docker.library_variable_sets) == 0 ? 1 : 0
  name        = "Docker"
  description = "Credentials used to interact with Docker"
}

resource "octopusdeploy_variable" "docker_username" {
  count        = length(data.octopusdeploy_library_variable_sets.docker.library_variable_sets) == 0 ? 1 : 0
  name         = "Docker.Credentials.Username"
  type         = "String"
  description  = "The Docker username"
  is_sensitive = false
  is_editable  = true
  owner_id     = octopusdeploy_library_variable_set.docker[0].id
  value        = var.feed_docker_hub_username
}

resource "octopusdeploy_variable" "docker_password" {
  count           = length(data.octopusdeploy_library_variable_sets.docker.library_variable_sets) == 0 ? 1 : 0
  name            = "Docker.Credentials.Password"
  type            = "Sensitive"
  description     = "The Docker password"
  is_sensitive    = true
  is_editable     = true
  owner_id        = octopusdeploy_library_variable_set.docker[0].id
  sensitive_value = var.feed_docker_hub_password
}


data "octopusdeploy_library_variable_sets" "github" {
  partial_name = "GitHub"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_library_variable_set" "github" {
  count       = length(data.octopusdeploy_library_variable_sets.github.library_variable_sets) == 0 ? 1 : 0
  name        = "GitHub"
  description = "Credentials used to interact with GitHub"
}

variable "github_access_token" {
  type        = string
  nullable    = false
  sensitive   = true
  description = "The GitHub access token"
}

resource "octopusdeploy_variable" "github_access_token" {
  count           = length(data.octopusdeploy_library_variable_sets.github.library_variable_sets) == 0 ? 1 : 0
  name            = "Git.Credentials.Password"
  type            = "Sensitive"
  description     = "The GitHub access token"
  is_sensitive    = true
  is_editable     = true
  owner_id        = octopusdeploy_library_variable_set.github[0].id
  sensitive_value = var.github_access_token
}
#endregion
