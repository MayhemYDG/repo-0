#region Projects

#region Infrastructure Project
data "octopusdeploy_projects" "infrastructure" {
  partial_name = local.infrastructure_project_name
  skip         = 0
  take         = 1
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
  project_group_id                     = local.project_group_id
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
    ignore_changes = [connectivity_policy]
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

#region Octopub Frontend Project
data "octopusdeploy_projects" "frontend" {
  partial_name = local.octopub_frontend_project_name
  skip         = 0
  take         = 1
}

resource "octopusdeploy_project" "frontend" {
  count                                = length(data.octopusdeploy_projects.frontend.projects) == 0 ? 1 : 0
  name                                 = local.octopub_frontend_project_name
  auto_create_release                  = false
  default_guided_failure_mode          = "EnvironmentDefault"
  default_to_skip_if_already_installed = false
  discrete_channel_release             = false
  is_disabled                          = false
  is_version_controlled                = true
  lifecycle_id                         = local.devops_lifecycle_id
  project_group_id                     = local.project_group_id
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
    ignore_changes = [connectivity_policy]
  }
  description = local.octopub_frontend_project_description
}
#endregion

#region Octopub Products Project
data "octopusdeploy_projects" "products" {
  partial_name = local.octopub_products_project_name
  skip         = 0
  take         = 1
}

resource "octopusdeploy_project" "products" {
  count                                = length(data.octopusdeploy_projects.products.projects) == 0 ? 1 : 0
  name                                 = local.octopub_products_project_name
  auto_create_release                  = false
  default_guided_failure_mode          = "EnvironmentDefault"
  default_to_skip_if_already_installed = false
  discrete_channel_release             = false
  is_disabled                          = false
  is_version_controlled                = true
  lifecycle_id                         = local.devops_lifecycle_id
  project_group_id                     = local.project_group_id
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
    ignore_changes = [connectivity_policy]
  }
  description = local.octopub_products_project_description
}
#endregion

#region Octopub Audits Project
data "octopusdeploy_projects" "audits" {
  partial_name = local.octopub_audits_project_name
  skip         = 0
  take         = 1
}

resource "octopusdeploy_project" "frontend" {
  count                                = length(data.octopusdeploy_projects.audits.projects) == 0 ? 1 : 0
  name                                 = local.octopub_audits_project_name
  auto_create_release                  = false
  default_guided_failure_mode          = "EnvironmentDefault"
  default_to_skip_if_already_installed = false
  discrete_channel_release             = false
  is_disabled                          = false
  is_version_controlled                = true
  lifecycle_id                         = local.devops_lifecycle_id
  project_group_id                     = local.project_group_id
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
    ignore_changes = [connectivity_policy]
  }
  description = local.octopub_audits_project_description
}
#endregion

#region Octopub Orchestration Project
data "octopusdeploy_projects" "orchestration" {
  partial_name = local.octopub_orchestration_project_name
  skip         = 0
  take         = 1
}

resource "octopusdeploy_project" "orchestration" {
  count                                = length(data.octopusdeploy_projects.orchestration.projects) == 0 ? 1 : 0
  name                                 = local.octopub_orchestration_project_name
  auto_create_release                  = false
  default_guided_failure_mode          = "EnvironmentDefault"
  default_to_skip_if_already_installed = false
  discrete_channel_release             = false
  is_disabled                          = false
  is_version_controlled                = false
  lifecycle_id                         = local.devops_lifecycle_id
  project_group_id                     = local.project_group_id
  included_library_variable_sets       = []
  tenanted_deployment_participation    = "Untenanted"

  connectivity_policy {
    allow_deployments_to_no_targets = true
    exclude_unhealthy_targets       = false
    skip_machine_behavior           = "None"
  }

  versioning_strategy {
    template = "#{Octopus.Version.LastMajor}.#{Octopus.Version.LastMinor}.#{Octopus.Version.NextPatch}"
  }

  lifecycle {
    ignore_changes = []
  }
  description = local.octopub_products_project_description
}

resource "octopusdeploy_deployment_process" "orchestration" {
  project_id = octopusdeploy_project.orchestration.id
  count                                = length(data.octopusdeploy_projects.orchestration.projects) == 0 ? 1 : 0

  step {
    condition           = "Success"
    name                = "Deploy Frontend"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.DeployRelease"
      name                               = "Deploy Frontend"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = true
      is_required                        = false
      worker_pool_id                     = ""
      properties                         = {
        "Octopus.Action.Package.DownloadOnTentacle" = "NotAcquired"
        "Octopus.Action.RunOnServer" = "True"
        "Octopus.Action.DeployRelease.DeploymentCondition" = "Always"
        "Octopus.Action.DeployRelease.ProjectId" = length(data.octopusdeploy_projects.frontend.projects) == 0 ? octopusdeploy_project.frontend.id : data.octopusdeploy_projects.frontend.projects[0].id
      }
      environments                       = []
      excluded_environments              = []
      channels                           = []
      tenant_tags                        = []

      primary_package {
        package_id           = length(data.octopusdeploy_projects.frontend.projects) == 0 ? octopusdeploy_project.frontend.id : data.octopusdeploy_projects.frontend.projects[0].id
        acquisition_location = "NotAcquired"
        feed_id              = data.octopusdeploy_feeds.project.feeds[0].id
        properties           = {}
      }

      features = []
    }

    properties   = {}
    target_roles = []
  }
  step {
    condition           = "Success"
    name                = "Deploy Products"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.DeployRelease"
      name                               = "Deploy Products"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = true
      is_required                        = false
      worker_pool_id                     = ""
      properties                         = {
        "Octopus.Action.DeployRelease.ProjectId" = length(data.octopusdeploy_projects.products.projects) == 0 ? octopusdeploy_project.products.id : data.octopusdeploy_projects.products.projects[0].id
        "Octopus.Action.Package.DownloadOnTentacle" = "NotAcquired"
        "Octopus.Action.RunOnServer" = "True"
        "Octopus.Action.DeployRelease.DeploymentCondition" = "Always"
      }
      environments                       = []
      excluded_environments              = []
      channels                           = []
      tenant_tags                        = []

      primary_package {
        package_id           = length(data.octopusdeploy_projects.products.projects) == 0 ? octopusdeploy_project.products.id : data.octopusdeploy_projects.products.projects[0].id
        acquisition_location = "NotAcquired"
        feed_id              = data.octopusdeploy_feeds.project.feeds[0].id
        properties           = {}
      }

      features = []
    }

    properties   = {}
    target_roles = []
  }
  step {
    condition           = "Success"
    name                = "Deploy Audits"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.DeployRelease"
      name                               = "Deploy Audits"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = true
      is_required                        = false
      worker_pool_id                     = ""
      properties                         = {
        "Octopus.Action.RunOnServer" = "True"
        "Octopus.Action.DeployRelease.DeploymentCondition" = "Always"
        "Octopus.Action.DeployRelease.ProjectId" = length(data.octopusdeploy_projects.audits.projects) == 0 ? octopusdeploy_project.audits.id : data.octopusdeploy_projects.audits.projects[0].id
        "Octopus.Action.Package.DownloadOnTentacle" = "NotAcquired"
      }
      environments                       = []
      excluded_environments              = []
      channels                           = []
      tenant_tags                        = []

      primary_package {
        package_id           = length(data.octopusdeploy_projects.audits.projects) == 0 ? octopusdeploy_project.audits.id : data.octopusdeploy_projects.audits.projects[0].id
        acquisition_location = "NotAcquired"
        feed_id              = data.octopusdeploy_feeds.project.feeds[0].id
        properties           = {}
      }

      features = []
    }

    properties   = {}
    target_roles = []
  }
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
        "Octopus.Action.Script.ScriptBody" = local.feedback_script
        "Octopus.Action.Script.ScriptSource" = "Inline"
        "Octopus.Action.Script.Syntax" = "PowerShell"
        "Octopus.Action.RunOnServer" = "true"
      }
      environments                       = []
      excluded_environments              = []
      channels                           = []
      tenant_tags                        = []
      features                           = []
    }

    properties   = {}
    target_roles = []
  }
}
#endregion

#endregion
