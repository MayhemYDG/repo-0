#region Environments
data "octopusdeploy_environments" "environment_development" {
  ids          = null
  partial_name = "Development"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_environment" "environment_development" {
  count                        = length(data.octopusdeploy_environments.environment_development.environments) == 0 ? 1 : 0
  name                         = "Development"
  description                  = ""
  allow_dynamic_infrastructure = true
  use_guided_failure           = true
  sort_order                   = 10

  jira_extension_settings {
    environment_type = "development"
  }

  jira_service_management_extension_settings {
    is_enabled = false
  }

  servicenow_extension_settings {
    is_enabled = false
  }
}

data "octopusdeploy_environments" "environment_test" {
  ids          = null
  partial_name = "Test"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_environment" "environment_test" {
  count                        = length(data.octopusdeploy_environments.environment_test.environments) == 0 ? 1 : 0
  name                         = "Test"
  description                  = ""
  allow_dynamic_infrastructure = true
  use_guided_failure           = true
  sort_order                   = 11

  jira_extension_settings {
    environment_type = "testing"
  }

  jira_service_management_extension_settings {
    is_enabled = false
  }

  servicenow_extension_settings {
    is_enabled = false
  }
}

data "octopusdeploy_environments" "environment_production" {
  ids          = null
  partial_name = "Production"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_environment" "environment_production" {
  count                        = length(data.octopusdeploy_environments.environment_production.environments) == 0 ? 1 : 0
  name                         = "Production"
  description                  = ""
  allow_dynamic_infrastructure = true
  use_guided_failure           = true
  sort_order                   = 12

  jira_extension_settings {
    environment_type = "production"
  }

  jira_service_management_extension_settings {
    is_enabled = false
  }

  servicenow_extension_settings {
    is_enabled = false
  }
}

data "octopusdeploy_environments" "environment_security" {
  ids          = null
  partial_name = "Security"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_environment" "environment_security" {
  count                        = length(data.octopusdeploy_environments.environment_security.environments) == 0 ? 1 : 0
  name                         = "Security"
  description                  = ""
  allow_dynamic_infrastructure = true
  use_guided_failure           = false
  sort_order                   = 14

  jira_extension_settings {
    environment_type = "production"
  }

  jira_service_management_extension_settings {
    is_enabled = false
  }

  servicenow_extension_settings {
    is_enabled = false
  }
}

data "octopusdeploy_environments" "environment_sync" {
  ids          = null
  partial_name = "Sync"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_environment" "environment_sync" {
  count                        = length(data.octopusdeploy_environments.environment_sync.environments) == 0 ? 1 : 0
  name                         = "Sync"
  description                  = ""
  allow_dynamic_infrastructure = true
  use_guided_failure           = false
  sort_order                   = 15

  jira_extension_settings {
    environment_type = "development"
  }

  jira_service_management_extension_settings {
    is_enabled = false
  }

  servicenow_extension_settings {
    is_enabled = false
  }
}

data "octopusdeploy_lifecycles" "devsecops" {
  ids          = []
  partial_name = "DevSecOps"
  skip         = 0
  take         = 1
}

data "octopusdeploy_lifecycles" "application" {
  ids          = []
  partial_name = "Application"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_lifecycle" "lifecycle_devsecops" {
  count       = length(data.octopusdeploy_lifecycles.devsecops.lifecycles) == 0 ? 1 : 0
  name        = "DevSecOps"
  description = ""

  phase {
    automatic_deployment_targets = []
    optional_deployment_targets  = [
      local.development_environment_id
    ]
    name                                  = "Development"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }
  phase {
    automatic_deployment_targets = []
    optional_deployment_targets  = [
      local.test_environment_id
    ]
    name                                  = "Test"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }
  phase {
    automatic_deployment_targets = []
    optional_deployment_targets  = [
      local.production_environment_id
    ]
    name                                  = "Production"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }
  phase {
    automatic_deployment_targets = [
      local.security_environment_id
    ]
    optional_deployment_targets           = []
    name                                  = "Security"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }

  release_retention_policy {
    quantity_to_keep    = 3
    should_keep_forever = false
    unit                = "Days"
  }

  tentacle_retention_policy {
    quantity_to_keep    = 3
    should_keep_forever = false
    unit                = "Days"
  }
}

resource "octopusdeploy_lifecycle" "lifecycle_application" {
  count       = length(data.octopusdeploy_lifecycles.application.lifecycles) == 0 ? 1 : 0
  name        = "Application"
  description = ""

  phase {
    automatic_deployment_targets = []
    optional_deployment_targets  = [
      local.development_environment_id
    ]
    name                                  = "Development"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }
  phase {
    automatic_deployment_targets = []
    optional_deployment_targets  = [
      local.test_environment_id
    ]
    name                                  = "Test"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }
  phase {
    automatic_deployment_targets = []
    optional_deployment_targets  = [
      local.production_environment_id
    ]
    name                                  = "Production"
    is_optional_phase                     = false
    minimum_environments_before_promotion = 0
  }

  release_retention_policy {
    quantity_to_keep    = 3
    should_keep_forever = false
    unit                = "Days"
  }

  tentacle_retention_policy {
    quantity_to_keep    = 3
    should_keep_forever = false
    unit                = "Days"
  }
}
#endregion
