#region Projects
data "octopusdeploy_projects" "infrastructure" {
  cloned_from_project_id = ""
  ids                    = []
  is_clone               = true
  partial_name           = local.infrastructure_project_name
  skip                   = 0
  take                   = 1
}

resource "octopusdeploy_project" "infrastructure" {
  count                                = length(data.octopusdeploy_projects.infrastructure.projects) == 0 ? 1 : 0
  name                                 = local.infrastructure_project_name
  auto_create_release                  = false
  default_guided_failure_mode          = "EnvironmentDefault"
  default_to_skip_if_already_installed = false
  discrete_channel_release             = false
  is_disabled                          = false
  is_version_controlled                = true
  lifecycle_id                         = local.devops_lifecycle_id
  project_group_id                     = local.project_group_name
  included_library_variable_sets       = []
  tenanted_deployment_participation    = "Untenanted"

  connectivity_policy {
    allow_deployments_to_no_targets = false
    exclude_unhealthy_targets       = false
    skip_machine_behavior           = "None"
  }

  versioning_strategy {
    template = ""
  }

  lifecycle {
    ignore_changes = ["connectivity_policy"]
  }
  description = local.infrastructure_project_description
}

resource "octopusdeploy_runbook" "runbook_create_infrastructure" {
  count             = length(data.octopusdeploy_projects.infrastructure.projects) == 0 ? 1 : 0
  name              = local.infrastructure_runbook_name
  project_id        = octopusdeploy_project.infrastructure[0].id
  environment_scope = "Specified"
  environments      = [
    local.development_environment_id,
    local.test_environment_id,
    local.production_environment_id,
  ]
  force_package_download      = false
  default_guided_failure_mode = "EnvironmentDefault"
  description                 = local.infrastructure_runbook_description
  multi_tenancy_mode          = "Untenanted"

  retention_policy {
    quantity_to_keep    = 100
    should_keep_forever = false
  }

  connectivity_policy {
    allow_deployments_to_no_targets = true
    exclude_unhealthy_targets       = false
    skip_machine_behavior           = "None"
  }
}

resource "octopusdeploy_runbook_process" "runbook_process_runbook_create_infrastructure" {
  count      = length(data.octopusdeploy_projects.infrastructure.projects) == 0 ? 1 : 0
  runbook_id = octopusdeploy_runbook.runbook_create_infrastructure[0].id

  step {
    condition           = "Always"
    name                = "Feedback"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Feedback"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = false
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "Octopus.Action.RunOnServer"         = "true"
        "Octopus.Action.Script.ScriptSource" = "Inline"
        "Octopus.Action.Script.Syntax"       = "PowerShell"
        "Octopus.Action.Script.ScriptBody"   = local.feedback_script
      }
      environments          = []
      excluded_environments = []
      channels              = []
      tenant_tags           = []
      features              = []
    }

    properties   = {}
    target_roles = []
  }
}
#endregion
