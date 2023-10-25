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

resource "octopusdeploy_project" "audits" {
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
  project_id = octopusdeploy_project.orchestration[0].id
  count      = length(data.octopusdeploy_projects.orchestration.projects) == 0 ? 1 : 0

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
        "Octopus.Action.Package.DownloadOnTentacle"        = "NotAcquired"
        "Octopus.Action.RunOnServer"                       = "True"
        "Octopus.Action.DeployRelease.DeploymentCondition" = "Always"
        "Octopus.Action.DeployRelease.ProjectId"           = length(data.octopusdeploy_projects.frontend.projects) == 0 ? octopusdeploy_project.frontend[0].id : data.octopusdeploy_projects.frontend.projects[0].id
      }
      environments          = []
      excluded_environments = []
      channels              = []
      tenant_tags           = []

      primary_package {
        package_id           = length(data.octopusdeploy_projects.frontend.projects) == 0 ? octopusdeploy_project.frontend[0].id : data.octopusdeploy_projects.frontend.projects[0].id
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
        "Octopus.Action.DeployRelease.ProjectId"           = length(data.octopusdeploy_projects.products.projects) == 0 ? octopusdeploy_project.products[0].id : data.octopusdeploy_projects.products.projects[0].id
        "Octopus.Action.Package.DownloadOnTentacle"        = "NotAcquired"
        "Octopus.Action.RunOnServer"                       = "True"
        "Octopus.Action.DeployRelease.DeploymentCondition" = "Always"
      }
      environments          = []
      excluded_environments = []
      channels              = []
      tenant_tags           = []

      primary_package {
        package_id           = length(data.octopusdeploy_projects.products.projects) == 0 ? octopusdeploy_project.products[0].id : data.octopusdeploy_projects.products.projects[0].id
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
        "Octopus.Action.RunOnServer"                       = "True"
        "Octopus.Action.DeployRelease.DeploymentCondition" = "Always"
        "Octopus.Action.DeployRelease.ProjectId"           = length(data.octopusdeploy_projects.audits.projects) == 0 ? octopusdeploy_project.audits[0].id : data.octopusdeploy_projects.audits.projects[0].id
        "Octopus.Action.Package.DownloadOnTentacle"        = "NotAcquired"
      }
      environments          = []
      excluded_environments = []
      channels              = []
      tenant_tags           = []

      primary_package {
        package_id           = length(data.octopusdeploy_projects.audits.projects) == 0 ? octopusdeploy_project.audits[0].id : data.octopusdeploy_projects.audits.projects[0].id
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
        "Octopus.Action.Script.ScriptBody"   = local.feedback_script
        "Octopus.Action.Script.ScriptSource" = "Inline"
        "Octopus.Action.Script.Syntax"       = "PowerShell"
        "Octopus.Action.RunOnServer"         = "true"
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

#region Project Templates
data "octopusdeploy_projects" "docker_project_template" {
  partial_name = "Docker Project Templates"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_variable" "docker_project_template_git_organization" {
  count        = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0
  owner_id     = octopusdeploy_project.docker_project_template[0].id
  value        = ""
  name         = "Git.Url.Organization"
  type         = "String"
  description  = "The GitHub organization to create the repo in."
  is_sensitive = false

  prompt {
    description = "The Github organization where the repo will be created. This is the `owner` part of the URL `https://github.com/owner/myrepo`."
    label       = "Github Organization"
    is_required = true
    display_settings {
      control_type = "SingleLineText"
    }
  }

  scope {
    actions      = []
    channels     = []
    environments = [local.sync_environment_id]
    machines     = []
    roles        = null
    tenant_tags  = null
  }
}

resource "octopusdeploy_variable" "docker_project_template_git_repo" {
  count        = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0
  owner_id     = octopusdeploy_project.docker_project_template[0].id
  value        = ""
  name         = "Git.Url.Repo"
  type         = "String"
  description  = "The GitHub repo to create."
  is_sensitive = false

  prompt {
    description = "The Github repo to be created. This is the `myrepo` part of the URL `https://github.com/owner/myrepo`."
    label       = "Github Repo"
    is_required = true
    display_settings {
      control_type = "SingleLineText"
    }
  }

  scope {
    actions      = []
    channels     = []
    environments = [local.sync_environment_id]
    machines     = []
    roles        = null
    tenant_tags  = null
  }
}

resource "octopusdeploy_variable" "docker_project_template_image_name" {
  count        = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0
  owner_id     = octopusdeploy_project.docker_project_template[0].id
  value        = ""
  name         = "Application.Docker.Image"
  type         = "String"
  description  = "The Docker image to create containing the new application."
  is_sensitive = false

  prompt {
    description = "The Docker image to create containing the new application."
    label       = "Docker Image"
    is_required = true
    display_settings {
      control_type = "SingleLineText"
    }
  }

  scope {
    actions      = []
    channels     = []
    environments = [local.sync_environment_id]
    machines     = []
    roles        = null
    tenant_tags  = null
  }
}

resource "octopusdeploy_variable" "docker_project_template_octopus_project" {
  count        = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0
  owner_id     = octopusdeploy_project.docker_project_template[0].id
  value        = ""
  name         = "Application.Octopus.Project"
  type         = "String"
  description  = "The Octopus project to associate with the new application."
  is_sensitive = false

  prompt {
    description = "The Octopus project to associate with the new application. A release is created in this project when the image is successfully built."
    label       = "Octopus Project"
    is_required = true
    display_settings {
      control_type = "SingleLineText"
    }
  }

  scope {
    actions      = []
    channels     = []
    environments = [local.sync_environment_id]
    machines     = []
    roles        = null
    tenant_tags  = null
  }
}

resource "octopusdeploy_project" "docker_project_template" {
  count                                = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0
  name                                 = "Docker Project Templates"
  auto_create_release                  = false
  default_guided_failure_mode          = "Off"
  default_to_skip_if_already_installed = false
  discrete_channel_release             = false
  is_disabled                          = false
  is_version_controlled                = false
  lifecycle_id                         = local.application_lifecycle_id
  project_group_id                     = local.project_templates_project_group_id
  included_library_variable_sets       = [
    local.this_instance_library_variable_set, local.github_library_variable_set, local.docker_library_variable_set
  ]
  tenanted_deployment_participation = "Untenanted"

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
  description = <<EOT
Creates Project Templates.
EOT
}

resource "octopusdeploy_runbook" "docker_project_template_create_nodejs_template" {
  count                       = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0
  name                        = "📗 Create Template Github Node.js Project"
  project_id                  = octopusdeploy_project.docker_project_template[0].id
  environment_scope           = "Specified"
  environments                = [data.octopusdeploy_environments.environment_sync.environments[0].id]
  force_package_download      = false
  default_guided_failure_mode = "EnvironmentDefault"
  description                 = "This runbook populates a GitHub repo with a sample Node.js project and GitHub Actions Workflow that builds a Docker image, pushes it to DockerHub, and triggers the deployment of the associated Octopus project in the Development environment. \n\n**Action**: Creates a new GitHub repo (if it doesn't exist) and populates it with the output of a Yeoman generator.\n\n\n**Affects**: This will overwrite files in the target Git repo. Changes can be reverted with git."
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

resource "octopusdeploy_runbook_process" "docker_project_template_create_nodejs_template" {
  runbook_id = octopusdeploy_runbook.docker_project_template_create_nodejs_template[0].id
  count      = length(data.octopusdeploy_projects.docker_project_template.projects) == 0 ? 1 : 0

  step {
    condition           = "Success"
    name                = "Get Variables"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Get Variables"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = false
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "Octopus.Action.Script.ScriptBody"   = "# This is a workaround to the issue where octostache templates in the Terraform\n# project are replaced during deployment, when we actually want some variables\n# at run time.\n\nSet-OctopusVariable -name \"Project.Name\" -value $OctopusParameters[\"Octopus.Project.Name\"]\nSet-OctopusVariable -name \"Web.ServerUri\" -value $OctopusParameters[\"Octopus.Web.ServerUri\"]\nSet-OctopusVariable -name \"Space.Id\" -value $OctopusParameters[\"Octopus.Space.Id\"]\nSet-OctopusVariable -name \"Space.Name\" -value $OctopusParameters[\"Octopus.Space.Name\"]"
        "Octopus.Action.RunOnServer"         = "true"
        "Octopus.Action.Script.ScriptSource" = "Inline"
        "Octopus.Action.Script.Syntax"       = "PowerShell"
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
  step {
    condition           = "Success"
    name                = "Create Repo"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Create Repo"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = false
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "CreateGithubRepo.Git.Url.Organization"        = "#{Git.Url.Organization}"
        "Octopus.Action.Script.Syntax"                 = "Python"
        "Octopus.Action.RunOnServer"                   = "true"
        "CreateGithubRepo.Git.Url.NewRepoNamePrefix"   = ""
        "CreateGithubRepo.Git.Credentials.AccessToken" = "#{Git.Credentials.Password}"
        "Octopus.Action.Script.ScriptBody"             = "# This script forks a GitHub repo. It creates a token from a GitHub App installation to avoid\n# having to use a regular user account.\nimport subprocess\nimport sys\n\n# Install our own dependencies\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'jwt', '--disable-pip-version-check'])\n\nimport json\nimport subprocess\nimport sys\nimport os\nimport urllib.request\nimport base64\nimport re\nimport jwt\nimport time\nimport argparse\nimport platform\nfrom urllib.request import urlretrieve\n\n# If this script is not being run as part of an Octopus step, setting variables is a noop\nif 'set_octopusvariable' not in globals():\n    def set_octopusvariable(variable, value):\n        pass\n\n# If this script is not being run as part of an Octopus step, return variables from environment variables.\n# Periods are replaced with underscores, and the variable name is converted to uppercase\nif \"get_octopusvariable\" not in globals():\n    def get_octopusvariable(variable):\n        return os.environ[re.sub('\\\\.', '_', variable.upper())]\n\n# If this script is not being run as part of an Octopus step, print directly to std out.\nif 'printverbose' not in globals():\n    def printverbose(msg):\n        print(msg)\n\n\ndef printverbose_noansi(output):\n    \"\"\"\n    Strip ANSI color codes and print the output as verbose\n    :param output: The output to print\n    \"\"\"\n    output_no_ansi = re.sub(r'\\x1b\\[[0-9;]*m', '', output)\n    printverbose(output_no_ansi)\n\n\ndef get_octopusvariable_quiet(variable):\n    \"\"\"\n    Gets an octopus variable, or an empty string if it does not exist.\n    :param variable: The variable name\n    :return: The variable value, or an empty string if the variable does not exist\n    \"\"\"\n    try:\n        return get_octopusvariable(variable)\n    except:\n        return ''\n\n\ndef execute(args, cwd=None, env=None, print_args=None, print_output=printverbose_noansi, raise_on_non_zero=False,\n            append_to_path=None):\n    \"\"\"\n        The execute method provides the ability to execute external processes while capturing and returning the\n        output to std err and std out and exit code.\n    \"\"\"\n\n    my_env = os.environ.copy() if env is None else env\n\n    if append_to_path is not None:\n        my_env[\"PATH\"] = append_to_path + os.pathsep + my_env['PATH']\n\n    process = subprocess.Popen(args,\n                               stdout=subprocess.PIPE,\n                               stderr=subprocess.PIPE,\n                               stdin=open(os.devnull),\n                               text=True,\n                               cwd=cwd,\n                               env=my_env)\n    stdout, stderr = process.communicate()\n    retcode = process.returncode\n\n    if not retcode == 0 and raise_on_non_zero:\n        raise Exception('command returned exit code ' + retcode)\n\n    if print_args is not None:\n        print_output(' '.join(args))\n\n    if print_output is not None:\n        print_output(stdout)\n        print_output(stderr)\n\n    return stdout, stderr, retcode\n\n\ndef init_argparse():\n    parser = argparse.ArgumentParser(\n        usage='%(prog)s [OPTION]',\n        description='Create a GitHub repo'\n    )\n    parser.add_argument('--new-repo-name', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.Git.Url.NewRepoName') or get_octopusvariable_quiet(\n                            'Git.Url.NewRepoName') or get_octopusvariable_quiet('Octopus.Project.Name'))\n    parser.add_argument('--new-repo-name-prefix', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.Git.Url.NewRepoNamePrefix') or get_octopusvariable_quiet(\n                            'Git.Url.NewRepoNamePrefix'))\n    parser.add_argument('--git-organization', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.Git.Url.Organization') or get_octopusvariable_quiet(\n                            'Git.Url.Organization'))\n    parser.add_argument('--github-app-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.GitHub.App.Id') or get_octopusvariable_quiet('GitHub.App.Id'))\n    parser.add_argument('--github-app-installation-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.GitHub.App.InstallationId') or get_octopusvariable_quiet(\n                            'GitHub.App.InstallationId'))\n    parser.add_argument('--github-app-private-key', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.GitHub.App.PrivateKey') or get_octopusvariable_quiet(\n                            'GitHub.App.PrivateKey'))\n    parser.add_argument('--github-access-token', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGithubRepo.Git.Credentials.AccessToken') or get_octopusvariable_quiet(\n                            'Git.Credentials.AccessToken'),\n                        help='The git password')\n\n    return parser.parse_known_args()\n\n\ndef generate_github_token(github_app_id, github_app_private_key, github_app_installation_id):\n    # Generate the tokens used by git and the GitHub API\n    app_id = github_app_id\n    signing_key = jwt.jwk_from_pem(github_app_private_key.encode('utf-8'))\n\n    payload = {\n        # Issued at time\n        'iat': int(time.time()),\n        # JWT expiration time (10 minutes maximum)\n        'exp': int(time.time()) + 600,\n        # GitHub App's identifier\n        'iss': app_id\n    }\n\n    # Create JWT\n    jwt_instance = jwt.JWT()\n    encoded_jwt = jwt_instance.encode(payload, signing_key, alg='RS256')\n\n    # Create access token\n    url = 'https://api.github.com/app/installations/' + github_app_installation_id + '/access_tokens'\n    headers = {\n        'Authorization': 'Bearer ' + encoded_jwt,\n        'Accept': 'application/vnd.github+json',\n        'X-GitHub-Api-Version': '2022-11-28'\n    }\n    request = urllib.request.Request(url, headers=headers, method='POST')\n    response = urllib.request.urlopen(request)\n    response_json = json.loads(response.read().decode())\n    return response_json['token']\n\n\ndef generate_auth_header(token):\n    auth = base64.b64encode(('x-access-token:' + token).encode('ascii'))\n    return 'Basic ' + auth.decode('ascii')\n\n\ndef verify_new_repo(token, cac_org, new_repo):\n    # Attempt to view the new repo\n    try:\n        url = 'https://api.github.com/repos/' + cac_org + '/' + new_repo\n        headers = {\n            'Accept': 'application/vnd.github+json',\n            'Authorization': 'Bearer ' + token,\n            'X-GitHub-Api-Version': '2022-11-28'\n        }\n        request = urllib.request.Request(url, headers=headers)\n        urllib.request.urlopen(request)\n        return True\n    except:\n        return False\n\n\ndef create_new_repo(token, cac_org, new_repo):\n    # If we could not view the repo, assume it needs to be created.\n    # https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-an-organization-repository\n    # Note you have to use the token rather than the JWT:\n    # https://stackoverflow.com/questions/39600396/bad-credentails-for-jwt-for-github-integrations-api\n\n    headers = {\n        'Authorization': 'token ' + token,\n        'Content-Type': 'application/json',\n        'Accept': 'application/vnd.github+json',\n        'X-GitHub-Api-Version': '2022-11-28',\n    }\n\n    try:\n        # First try to create an organization repo:\n        # https://docs.github.com/en/free-pro-team@latest/rest/repos/repos#create-an-organization-repository\n        url = 'https://api.github.com/orgs/' + cac_org + '/repos'\n        body = {'name': new_repo}\n        request = urllib.request.Request(url, headers=headers, data=json.dumps(body).encode('utf-8'))\n        urllib.request.urlopen(request)\n    except urllib.error.URLError as ex:\n        # Then fall back to creating a repo for the user:\n        # https://docs.github.com/en/free-pro-team@latest/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-for-the-authenticated-user\n        if ex.code == 404:\n            url = 'https://api.github.com/user/repos'\n            body = {'name': new_repo}\n            request = urllib.request.Request(url, headers=headers, data=json.dumps(body).encode('utf-8'))\n            urllib.request.urlopen(request)\n        else:\n            raise ValueError(\"Failed to create thew new repository. This could indicate bad credentials.\") from ex\n\n\ndef is_windows():\n    return platform.system() == 'Windows'\n\n\nparser, _ = init_argparse()\n\nif not parser.github_access_token.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.new_repo_name.strip():\n    print(\"You must define the new repo name\")\n    sys.exit(1)\n\n# The access token is generated from a github app or supplied directly as an access token\ntoken = generate_github_token(parser.github_app_id, parser.github_app_private_key, parser.github_app_installation_id) \\\n    if not parser.github_access_token.strip() else parser.github_access_token.strip()\n\ncac_org = parser.git_organization.strip()\nnew_repo_custom_prefix = re.sub('[^a-zA-Z0-9-]', '_', parser.new_repo_name_prefix.strip())\nproject_repo_sanitized = re.sub('[^a-zA-Z0-9-]', '_', parser.new_repo_name.strip())\n\n# The prefix is optional\nnew_repo_prefix_with_separator = new_repo_custom_prefix + '_' if new_repo_custom_prefix else ''\n\n# The new repo name is the prefix + the name of thew new project\nnew_repo = new_repo_prefix_with_separator + project_repo_sanitized\n\n# This is the value of the forked git repo\nset_octopusvariable('NewRepoUrl', 'https://github.com/' + cac_org + '/' + new_repo)\nset_octopusvariable('NewRepo', new_repo)\n\nif not verify_new_repo(token, cac_org, new_repo):\n    create_new_repo(token, cac_org, new_repo)\n    print(\n        'New repo was created at https://github.com/' + cac_org + '/' + new_repo)\nelse:\n    print('Repo at https://github.com/' + cac_org + '/' + new_repo + ' already exists and has not been modified')\n\nprint('New repo URL is defined in the output variable \"NewRepoUrl\": #{Octopus.Action[' +\n      get_octopusvariable_quiet('Octopus.Step.Name') + '].Output.NewRepoUrl}')\nprint('New repo name is defined in the output variable \"NewRepo\": #{Octopus.Action[' +\n      get_octopusvariable_quiet('Octopus.Step.Name') + '].Output.NewRepo}')\n"
        "CreateGithubRepo.Git.Url.NewRepoName"         = "#{Git.Url.Repo}"
        "Octopus.Action.Script.ScriptSource"           = "Inline"
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
  step {
    condition           = "Success"
    name                = "Create Octopus API Key Secret"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Create Octopus API Key Secret"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = false
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "Octopus.Action.Script.Syntax"                = "Python"
        "CreateGitHubSecret.Git.Credentials.Password" = "#{Git.Credentials.Password}"
        "CreateGitHubSecret.GitHub.Secret.Value"      = "#{Octopus.ApiKey}"
        "CreateGitHubSecret.Git.Url.Repo"             = "#{Octopus.Action[Create Repo].Output.NewRepo}"
        "Octopus.Action.RunOnServer"                  = "true"
        "Octopus.Action.Script.ScriptSource"          = "Inline"
        "CreateGitHubSecret.GitHub.Secret.Name"       = "OCTOPUS_API_TOKEN"
        "CreateGitHubSecret.Git.Url.Organization"     = "#{Git.Url.Organization}"
        "Octopus.Action.Script.ScriptBody"            = "# https://gist.github.com/comdotlinux/9a53bb00767a16d6646464c4b8249094\n\n# This script forks a GitHub repo. It creates a token from a GitHub App installation to avoid\n# having to use a regular user account.\nimport subprocess\nimport sys\n\n# Install our own dependencies\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'jwt', '--disable-pip-version-check'])\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pynacl', '--disable-pip-version-check'])\n\nimport requests\nimport json\nimport subprocess\nimport sys\nimport os\nimport urllib.request\nimport base64\nimport re\nimport jwt\nimport time\nimport argparse\nimport urllib3\nfrom base64 import b64encode\nfrom typing import TypedDict\nfrom nacl import public, encoding\n\n# Disable insecure http request warnings\nurllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)\n\n# If this script is not being run as part of an Octopus step, setting variables is a noop\nif 'set_octopusvariable' not in globals():\n    def set_octopusvariable(variable, value):\n        pass\n\n# If this script is not being run as part of an Octopus step, return variables from environment variables.\n# Periods are replaced with underscores, and the variable name is converted to uppercase\nif \"get_octopusvariable\" not in globals():\n    def get_octopusvariable(variable):\n        return os.environ[re.sub('\\\\.', '_', variable.upper())]\n\n# If this script is not being run as part of an Octopus step, print directly to std out.\nif 'printverbose' not in globals():\n    def printverbose(msg):\n        print(msg)\n\n\ndef printverbose_noansi(output):\n    \"\"\"\n    Strip ANSI color codes and print the output as verbose\n    :param output: The output to print\n    \"\"\"\n    output_no_ansi = re.sub(r'\\x1b\\[[0-9;]*m', '', output)\n    printverbose(output_no_ansi)\n\n\ndef get_octopusvariable_quiet(variable):\n    \"\"\"\n    Gets an octopus variable, or an empty string if it does not exist.\n    :param variable: The variable name\n    :return: The variable value, or an empty string if the variable does not exist\n    \"\"\"\n    try:\n        return get_octopusvariable(variable)\n    except:\n        return ''\n\n\ndef execute(args, cwd=None, env=None, print_args=None, print_output=printverbose_noansi, raise_on_non_zero=False,\n            append_to_path=None):\n    \"\"\"\n        The execute method provides the ability to execute external processes while capturing and returning the\n        output to std err and std out and exit code.\n    \"\"\"\n\n    my_env = os.environ.copy() if env is None else env\n\n    if append_to_path is not None:\n        my_env[\"PATH\"] = append_to_path + os.pathsep + my_env['PATH']\n\n    process = subprocess.Popen(args,\n                               stdout=subprocess.PIPE,\n                               stderr=subprocess.PIPE,\n                               stdin=open(os.devnull),\n                               text=True,\n                               cwd=cwd,\n                               env=my_env)\n    stdout, stderr = process.communicate()\n    retcode = process.returncode\n\n    if not retcode == 0 and raise_on_non_zero:\n        raise Exception('command returned exit code ' + retcode)\n\n    if print_args is not None:\n        print_output(' '.join(args))\n\n    if print_output is not None:\n        print_output(stdout)\n        print_output(stderr)\n\n    return stdout, stderr, retcode\n\n\ndef init_argparse():\n    parser = argparse.ArgumentParser(\n        usage='%(prog)s [OPTION]',\n        description='Fork a GitHub repo'\n    )\n\n    parser.add_argument('--secret-name', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.Secret.Name') or get_octopusvariable_quiet(\n                            'GitHub.Secret.Name'))\n    parser.add_argument('--secret-value', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.Secret.Value') or get_octopusvariable_quiet(\n                            'GitHub.Secret.Value'))\n\n    parser.add_argument('--repo', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Url.Repo') or get_octopusvariable_quiet(\n                            'Git.Url.Repo') or get_octopusvariable_quiet('Octopus.Project.Name'))\n    parser.add_argument('--git-organization', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Url.Organization') or get_octopusvariable_quiet(\n                            'Git.Url.Organization'))\n    parser.add_argument('--github-app-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.Id') or get_octopusvariable_quiet('GitHub.App.Id'))\n    parser.add_argument('--github-app-installation-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.InstallationId') or get_octopusvariable_quiet(\n                            'GitHub.App.InstallationId'))\n    parser.add_argument('--github-app-private-key', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.PrivateKey') or get_octopusvariable_quiet(\n                            'GitHub.App.PrivateKey'))\n    parser.add_argument('--git-password', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Credentials.Password') or get_octopusvariable_quiet(\n                            'Git.Credentials.Password'),\n                        help='The git password. This takes precedence over the --github-app-id,  --github-app-installation-id, and --github-app-private-key')\n\n    return parser.parse_known_args()\n\n\ndef generate_github_token(github_app_id, github_app_private_key, github_app_installation_id):\n    # Generate the tokens used by git and the GitHub API\n    app_id = github_app_id\n    signing_key = jwt.jwk_from_pem(github_app_private_key.encode('utf-8'))\n\n    payload = {\n        # Issued at time\n        'iat': int(time.time()),\n        # JWT expiration time (10 minutes maximum)\n        'exp': int(time.time()) + 600,\n        # GitHub App's identifier\n        'iss': app_id\n    }\n\n    # Create JWT\n    jwt_instance = jwt.JWT()\n    encoded_jwt = jwt_instance.encode(payload, signing_key, alg='RS256')\n\n    # Create access token\n    url = 'https://api.github.com/app/installations/' + github_app_installation_id + '/access_tokens'\n    headers = {\n        'Authorization': 'Bearer ' + encoded_jwt,\n        'Accept': 'application/vnd.github+json',\n        'X-GitHub-Api-Version': '2022-11-28'\n    }\n    request = urllib.request.Request(url, headers=headers, method='POST')\n    response = urllib.request.urlopen(request)\n    response_json = json.loads(response.read().decode())\n    return response_json['token']\n\n\ndef generate_auth_header(token):\n    auth = base64.b64encode(('x-access-token:' + token).encode('ascii'))\n    return 'Basic ' + auth.decode('ascii')\n\n\ndef verify_new_repo(token, cac_org, new_repo):\n    # Attempt to view the new repo\n    try:\n        url = 'https://api.github.com/repos/' + cac_org + '/' + new_repo\n        headers = {\n            'Accept': 'application/vnd.github+json',\n            'Authorization': 'Bearer ' + token,\n            'X-GitHub-Api-Version': '2022-11-28'\n        }\n        request = urllib.request.Request(url, headers=headers)\n        urllib.request.urlopen(request)\n        return True\n    except:\n        return False\n\n\ndef encrypt(public_key_for_repo: str, secret_value_input: str) -\u003e str:\n    \"\"\"Encrypt a Unicode string using the public key.\"\"\"\n    sealed_box = public.SealedBox(public.PublicKey(public_key_for_repo.encode(\"utf-8\"), encoding.Base64Encoder()))\n    encrypted = sealed_box.encrypt(secret_value_input.encode(\"utf-8\"))\n    return b64encode(encrypted).decode(\"utf-8\")\n\n\ndef get_public_key(gh_base_url: str, gh_owner: str, gh_repo: str, gh_auth_token: str) -\u003e (str, str):\n    public_key_endpoint: str = f\"{gh_base_url}/{gh_owner}/{gh_repo}/actions/secrets/public-key\"\n    headers: TypedDict[str, str] = {\"Authorization\": f\"Bearer {gh_auth_token}\"}\n    response = requests.get(url=public_key_endpoint, headers=headers)\n    if response.status_code != 200:\n        raise IOError(\n            f\"Could not get public key for repository {gh_owner}/{gh_repo}. The Response code was {response.status_code}\")\n\n    public_key_json = response.json()\n    return public_key_json['key_id'], public_key_json['key']\n\n\ndef set_secret(gh_base_url: str, gh_owner: str, gh_repo: str, gh_auth_token: str, public_key_id: str, secret_key: str,\n               encrypted_secret_value: str):\n    secret_creation_url = f\"{gh_base_url}/{gh_owner}/{gh_repo}/actions/secrets/{secret_key}\"\n    secret_creation_body = {\"key_id\": public_key_id, \"encrypted_value\": encrypted_secret_value}\n    headers: TypedDict[str, str] = {\"Authorization\": f\"Bearer {gh_auth_token}\", \"Content-Type\": \"application/json\"}\n\n    secret_creation_response = requests.put(url=secret_creation_url, json=secret_creation_body, headers=headers)\n    if secret_creation_response.status_code == 201 or secret_creation_response.status_code == 204:\n        print(\"--Secret Created / Updated!--\")\n    else:\n        print(f\"-- Error creating / updating github secret, the reason was : {secret_creation_response.reason}\")\n\n\nparser, _ = init_argparse()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\ntoken = generate_github_token(parser.github_app_id, parser.github_app_private_key,\n                              parser.github_app_installation_id) if len(\n    parser.git_password.strip()) == 0 else parser.git_password.strip()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\nif not parser.secret_name.strip():\n    print(\"You must define the secret name\")\n    sys.exit(1)\n    \nif not verify_new_repo(token, parser.git_organization, parser.repo):\n    print(\"Could not find the repo\")\n    sys.exit(1)\n\nkey_id, public_key = get_public_key('https://api.github.com/repos', parser.git_organization, parser.repo,\n                                    token)\nencrypted_secret: str = encrypt(public_key_for_repo=public_key, secret_value_input=parser.secret_value)\nset_secret(gh_base_url='https://api.github.com/repos', gh_owner=parser.git_organization, gh_repo=parser.repo,\n           gh_auth_token=token, public_key_id=key_id, secret_key=parser.secret_name,\n           encrypted_secret_value=encrypted_secret)\n"
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
  step {
    condition           = "Success"
    name                = "Create Docker Hub Password Secret"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Create Docker Hub Password Secret"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = false
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "CreateGitHubSecret.Git.Credentials.Password" = "#{Git.Credentials.Password}"
        "CreateGitHubSecret.GitHub.Secret.Name"       = "DOCKERHUB_TOKEN"
        "Octopus.Action.Script.Syntax"                = "Python"
        "CreateGitHubSecret.GitHub.Secret.Value"      = "#{Docker.Credentials.Password}"
        "CreateGitHubSecret.Git.Url.Organization"     = "#{Git.Url.Organization}"
        "Octopus.Action.Script.ScriptSource"          = "Inline"
        "Octopus.Action.RunOnServer"                  = "true"
        "CreateGitHubSecret.Git.Url.Repo"             = "#{Octopus.Action[Create Repo].Output.NewRepo}"
        "Octopus.Action.Script.ScriptBody"            = "# https://gist.github.com/comdotlinux/9a53bb00767a16d6646464c4b8249094\n\n# This script forks a GitHub repo. It creates a token from a GitHub App installation to avoid\n# having to use a regular user account.\nimport subprocess\nimport sys\n\n# Install our own dependencies\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'jwt', '--disable-pip-version-check'])\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pynacl', '--disable-pip-version-check'])\n\nimport requests\nimport json\nimport subprocess\nimport sys\nimport os\nimport urllib.request\nimport base64\nimport re\nimport jwt\nimport time\nimport argparse\nimport urllib3\nfrom base64 import b64encode\nfrom typing import TypedDict\nfrom nacl import public, encoding\n\n# Disable insecure http request warnings\nurllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)\n\n# If this script is not being run as part of an Octopus step, setting variables is a noop\nif 'set_octopusvariable' not in globals():\n    def set_octopusvariable(variable, value):\n        pass\n\n# If this script is not being run as part of an Octopus step, return variables from environment variables.\n# Periods are replaced with underscores, and the variable name is converted to uppercase\nif \"get_octopusvariable\" not in globals():\n    def get_octopusvariable(variable):\n        return os.environ[re.sub('\\\\.', '_', variable.upper())]\n\n# If this script is not being run as part of an Octopus step, print directly to std out.\nif 'printverbose' not in globals():\n    def printverbose(msg):\n        print(msg)\n\n\ndef printverbose_noansi(output):\n    \"\"\"\n    Strip ANSI color codes and print the output as verbose\n    :param output: The output to print\n    \"\"\"\n    output_no_ansi = re.sub(r'\\x1b\\[[0-9;]*m', '', output)\n    printverbose(output_no_ansi)\n\n\ndef get_octopusvariable_quiet(variable):\n    \"\"\"\n    Gets an octopus variable, or an empty string if it does not exist.\n    :param variable: The variable name\n    :return: The variable value, or an empty string if the variable does not exist\n    \"\"\"\n    try:\n        return get_octopusvariable(variable)\n    except:\n        return ''\n\n\ndef execute(args, cwd=None, env=None, print_args=None, print_output=printverbose_noansi, raise_on_non_zero=False,\n            append_to_path=None):\n    \"\"\"\n        The execute method provides the ability to execute external processes while capturing and returning the\n        output to std err and std out and exit code.\n    \"\"\"\n\n    my_env = os.environ.copy() if env is None else env\n\n    if append_to_path is not None:\n        my_env[\"PATH\"] = append_to_path + os.pathsep + my_env['PATH']\n\n    process = subprocess.Popen(args,\n                               stdout=subprocess.PIPE,\n                               stderr=subprocess.PIPE,\n                               stdin=open(os.devnull),\n                               text=True,\n                               cwd=cwd,\n                               env=my_env)\n    stdout, stderr = process.communicate()\n    retcode = process.returncode\n\n    if not retcode == 0 and raise_on_non_zero:\n        raise Exception('command returned exit code ' + retcode)\n\n    if print_args is not None:\n        print_output(' '.join(args))\n\n    if print_output is not None:\n        print_output(stdout)\n        print_output(stderr)\n\n    return stdout, stderr, retcode\n\n\ndef init_argparse():\n    parser = argparse.ArgumentParser(\n        usage='%(prog)s [OPTION]',\n        description='Fork a GitHub repo'\n    )\n\n    parser.add_argument('--secret-name', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.Secret.Name') or get_octopusvariable_quiet(\n                            'GitHub.Secret.Name'))\n    parser.add_argument('--secret-value', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.Secret.Value') or get_octopusvariable_quiet(\n                            'GitHub.Secret.Value'))\n\n    parser.add_argument('--repo', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Url.Repo') or get_octopusvariable_quiet(\n                            'Git.Url.Repo') or get_octopusvariable_quiet('Octopus.Project.Name'))\n    parser.add_argument('--git-organization', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Url.Organization') or get_octopusvariable_quiet(\n                            'Git.Url.Organization'))\n    parser.add_argument('--github-app-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.Id') or get_octopusvariable_quiet('GitHub.App.Id'))\n    parser.add_argument('--github-app-installation-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.InstallationId') or get_octopusvariable_quiet(\n                            'GitHub.App.InstallationId'))\n    parser.add_argument('--github-app-private-key', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.PrivateKey') or get_octopusvariable_quiet(\n                            'GitHub.App.PrivateKey'))\n    parser.add_argument('--git-password', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Credentials.Password') or get_octopusvariable_quiet(\n                            'Git.Credentials.Password'),\n                        help='The git password. This takes precedence over the --github-app-id,  --github-app-installation-id, and --github-app-private-key')\n\n    return parser.parse_known_args()\n\n\ndef generate_github_token(github_app_id, github_app_private_key, github_app_installation_id):\n    # Generate the tokens used by git and the GitHub API\n    app_id = github_app_id\n    signing_key = jwt.jwk_from_pem(github_app_private_key.encode('utf-8'))\n\n    payload = {\n        # Issued at time\n        'iat': int(time.time()),\n        # JWT expiration time (10 minutes maximum)\n        'exp': int(time.time()) + 600,\n        # GitHub App's identifier\n        'iss': app_id\n    }\n\n    # Create JWT\n    jwt_instance = jwt.JWT()\n    encoded_jwt = jwt_instance.encode(payload, signing_key, alg='RS256')\n\n    # Create access token\n    url = 'https://api.github.com/app/installations/' + github_app_installation_id + '/access_tokens'\n    headers = {\n        'Authorization': 'Bearer ' + encoded_jwt,\n        'Accept': 'application/vnd.github+json',\n        'X-GitHub-Api-Version': '2022-11-28'\n    }\n    request = urllib.request.Request(url, headers=headers, method='POST')\n    response = urllib.request.urlopen(request)\n    response_json = json.loads(response.read().decode())\n    return response_json['token']\n\n\ndef generate_auth_header(token):\n    auth = base64.b64encode(('x-access-token:' + token).encode('ascii'))\n    return 'Basic ' + auth.decode('ascii')\n\n\ndef verify_new_repo(token, cac_org, new_repo):\n    # Attempt to view the new repo\n    try:\n        url = 'https://api.github.com/repos/' + cac_org + '/' + new_repo\n        headers = {\n            'Accept': 'application/vnd.github+json',\n            'Authorization': 'Bearer ' + token,\n            'X-GitHub-Api-Version': '2022-11-28'\n        }\n        request = urllib.request.Request(url, headers=headers)\n        urllib.request.urlopen(request)\n        return True\n    except:\n        return False\n\n\ndef encrypt(public_key_for_repo: str, secret_value_input: str) -\u003e str:\n    \"\"\"Encrypt a Unicode string using the public key.\"\"\"\n    sealed_box = public.SealedBox(public.PublicKey(public_key_for_repo.encode(\"utf-8\"), encoding.Base64Encoder()))\n    encrypted = sealed_box.encrypt(secret_value_input.encode(\"utf-8\"))\n    return b64encode(encrypted).decode(\"utf-8\")\n\n\ndef get_public_key(gh_base_url: str, gh_owner: str, gh_repo: str, gh_auth_token: str) -\u003e (str, str):\n    public_key_endpoint: str = f\"{gh_base_url}/{gh_owner}/{gh_repo}/actions/secrets/public-key\"\n    headers: TypedDict[str, str] = {\"Authorization\": f\"Bearer {gh_auth_token}\"}\n    response = requests.get(url=public_key_endpoint, headers=headers)\n    if response.status_code != 200:\n        raise IOError(\n            f\"Could not get public key for repository {gh_owner}/{gh_repo}. The Response code was {response.status_code}\")\n\n    public_key_json = response.json()\n    return public_key_json['key_id'], public_key_json['key']\n\n\ndef set_secret(gh_base_url: str, gh_owner: str, gh_repo: str, gh_auth_token: str, public_key_id: str, secret_key: str,\n               encrypted_secret_value: str):\n    secret_creation_url = f\"{gh_base_url}/{gh_owner}/{gh_repo}/actions/secrets/{secret_key}\"\n    secret_creation_body = {\"key_id\": public_key_id, \"encrypted_value\": encrypted_secret_value}\n    headers: TypedDict[str, str] = {\"Authorization\": f\"Bearer {gh_auth_token}\", \"Content-Type\": \"application/json\"}\n\n    secret_creation_response = requests.put(url=secret_creation_url, json=secret_creation_body, headers=headers)\n    if secret_creation_response.status_code == 201 or secret_creation_response.status_code == 204:\n        print(\"--Secret Created / Updated!--\")\n    else:\n        print(f\"-- Error creating / updating github secret, the reason was : {secret_creation_response.reason}\")\n\n\nparser, _ = init_argparse()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\ntoken = generate_github_token(parser.github_app_id, parser.github_app_private_key,\n                              parser.github_app_installation_id) if len(\n    parser.git_password.strip()) == 0 else parser.git_password.strip()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\nif not parser.secret_name.strip():\n    print(\"You must define the secret name\")\n    sys.exit(1)\n    \nif not verify_new_repo(token, parser.git_organization, parser.repo):\n    print(\"Could not find the repo\")\n    sys.exit(1)\n\nkey_id, public_key = get_public_key('https://api.github.com/repos', parser.git_organization, parser.repo,\n                                    token)\nencrypted_secret: str = encrypt(public_key_for_repo=public_key, secret_value_input=parser.secret_value)\nset_secret(gh_base_url='https://api.github.com/repos', gh_owner=parser.git_organization, gh_repo=parser.repo,\n           gh_auth_token=token, public_key_id=key_id, secret_key=parser.secret_name,\n           encrypted_secret_value=encrypted_secret)\n"
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
  step {
    condition           = "Success"
    name                = "Create Docker Hub Password Username"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Create Docker Hub Password Username"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = false
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "CreateGitHubSecret.Git.Credentials.Password" = "#{Git.Credentials.Password}"
        "Octopus.Action.RunOnServer"                  = "true"
        "CreateGitHubSecret.GitHub.Secret.Value"      = "#{Docker.Credentials.Username}"
        "CreateGitHubSecret.Git.Url.Repo"             = "#{Octopus.Action[Create Repo].Output.NewRepo}"
        "Octopus.Action.Script.ScriptSource"          = "Inline"
        "Octopus.Action.Script.ScriptBody"            = "# https://gist.github.com/comdotlinux/9a53bb00767a16d6646464c4b8249094\n\n# This script forks a GitHub repo. It creates a token from a GitHub App installation to avoid\n# having to use a regular user account.\nimport subprocess\nimport sys\n\n# Install our own dependencies\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'jwt', '--disable-pip-version-check'])\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pynacl', '--disable-pip-version-check'])\n\nimport requests\nimport json\nimport subprocess\nimport sys\nimport os\nimport urllib.request\nimport base64\nimport re\nimport jwt\nimport time\nimport argparse\nimport urllib3\nfrom base64 import b64encode\nfrom typing import TypedDict\nfrom nacl import public, encoding\n\n# Disable insecure http request warnings\nurllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)\n\n# If this script is not being run as part of an Octopus step, setting variables is a noop\nif 'set_octopusvariable' not in globals():\n    def set_octopusvariable(variable, value):\n        pass\n\n# If this script is not being run as part of an Octopus step, return variables from environment variables.\n# Periods are replaced with underscores, and the variable name is converted to uppercase\nif \"get_octopusvariable\" not in globals():\n    def get_octopusvariable(variable):\n        return os.environ[re.sub('\\\\.', '_', variable.upper())]\n\n# If this script is not being run as part of an Octopus step, print directly to std out.\nif 'printverbose' not in globals():\n    def printverbose(msg):\n        print(msg)\n\n\ndef printverbose_noansi(output):\n    \"\"\"\n    Strip ANSI color codes and print the output as verbose\n    :param output: The output to print\n    \"\"\"\n    output_no_ansi = re.sub(r'\\x1b\\[[0-9;]*m', '', output)\n    printverbose(output_no_ansi)\n\n\ndef get_octopusvariable_quiet(variable):\n    \"\"\"\n    Gets an octopus variable, or an empty string if it does not exist.\n    :param variable: The variable name\n    :return: The variable value, or an empty string if the variable does not exist\n    \"\"\"\n    try:\n        return get_octopusvariable(variable)\n    except:\n        return ''\n\n\ndef execute(args, cwd=None, env=None, print_args=None, print_output=printverbose_noansi, raise_on_non_zero=False,\n            append_to_path=None):\n    \"\"\"\n        The execute method provides the ability to execute external processes while capturing and returning the\n        output to std err and std out and exit code.\n    \"\"\"\n\n    my_env = os.environ.copy() if env is None else env\n\n    if append_to_path is not None:\n        my_env[\"PATH\"] = append_to_path + os.pathsep + my_env['PATH']\n\n    process = subprocess.Popen(args,\n                               stdout=subprocess.PIPE,\n                               stderr=subprocess.PIPE,\n                               stdin=open(os.devnull),\n                               text=True,\n                               cwd=cwd,\n                               env=my_env)\n    stdout, stderr = process.communicate()\n    retcode = process.returncode\n\n    if not retcode == 0 and raise_on_non_zero:\n        raise Exception('command returned exit code ' + retcode)\n\n    if print_args is not None:\n        print_output(' '.join(args))\n\n    if print_output is not None:\n        print_output(stdout)\n        print_output(stderr)\n\n    return stdout, stderr, retcode\n\n\ndef init_argparse():\n    parser = argparse.ArgumentParser(\n        usage='%(prog)s [OPTION]',\n        description='Fork a GitHub repo'\n    )\n\n    parser.add_argument('--secret-name', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.Secret.Name') or get_octopusvariable_quiet(\n                            'GitHub.Secret.Name'))\n    parser.add_argument('--secret-value', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.Secret.Value') or get_octopusvariable_quiet(\n                            'GitHub.Secret.Value'))\n\n    parser.add_argument('--repo', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Url.Repo') or get_octopusvariable_quiet(\n                            'Git.Url.Repo') or get_octopusvariable_quiet('Octopus.Project.Name'))\n    parser.add_argument('--git-organization', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Url.Organization') or get_octopusvariable_quiet(\n                            'Git.Url.Organization'))\n    parser.add_argument('--github-app-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.Id') or get_octopusvariable_quiet('GitHub.App.Id'))\n    parser.add_argument('--github-app-installation-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.InstallationId') or get_octopusvariable_quiet(\n                            'GitHub.App.InstallationId'))\n    parser.add_argument('--github-app-private-key', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.GitHub.App.PrivateKey') or get_octopusvariable_quiet(\n                            'GitHub.App.PrivateKey'))\n    parser.add_argument('--git-password', action='store',\n                        default=get_octopusvariable_quiet(\n                            'CreateGitHubSecret.Git.Credentials.Password') or get_octopusvariable_quiet(\n                            'Git.Credentials.Password'),\n                        help='The git password. This takes precedence over the --github-app-id,  --github-app-installation-id, and --github-app-private-key')\n\n    return parser.parse_known_args()\n\n\ndef generate_github_token(github_app_id, github_app_private_key, github_app_installation_id):\n    # Generate the tokens used by git and the GitHub API\n    app_id = github_app_id\n    signing_key = jwt.jwk_from_pem(github_app_private_key.encode('utf-8'))\n\n    payload = {\n        # Issued at time\n        'iat': int(time.time()),\n        # JWT expiration time (10 minutes maximum)\n        'exp': int(time.time()) + 600,\n        # GitHub App's identifier\n        'iss': app_id\n    }\n\n    # Create JWT\n    jwt_instance = jwt.JWT()\n    encoded_jwt = jwt_instance.encode(payload, signing_key, alg='RS256')\n\n    # Create access token\n    url = 'https://api.github.com/app/installations/' + github_app_installation_id + '/access_tokens'\n    headers = {\n        'Authorization': 'Bearer ' + encoded_jwt,\n        'Accept': 'application/vnd.github+json',\n        'X-GitHub-Api-Version': '2022-11-28'\n    }\n    request = urllib.request.Request(url, headers=headers, method='POST')\n    response = urllib.request.urlopen(request)\n    response_json = json.loads(response.read().decode())\n    return response_json['token']\n\n\ndef generate_auth_header(token):\n    auth = base64.b64encode(('x-access-token:' + token).encode('ascii'))\n    return 'Basic ' + auth.decode('ascii')\n\n\ndef verify_new_repo(token, cac_org, new_repo):\n    # Attempt to view the new repo\n    try:\n        url = 'https://api.github.com/repos/' + cac_org + '/' + new_repo\n        headers = {\n            'Accept': 'application/vnd.github+json',\n            'Authorization': 'Bearer ' + token,\n            'X-GitHub-Api-Version': '2022-11-28'\n        }\n        request = urllib.request.Request(url, headers=headers)\n        urllib.request.urlopen(request)\n        return True\n    except:\n        return False\n\n\ndef encrypt(public_key_for_repo: str, secret_value_input: str) -\u003e str:\n    \"\"\"Encrypt a Unicode string using the public key.\"\"\"\n    sealed_box = public.SealedBox(public.PublicKey(public_key_for_repo.encode(\"utf-8\"), encoding.Base64Encoder()))\n    encrypted = sealed_box.encrypt(secret_value_input.encode(\"utf-8\"))\n    return b64encode(encrypted).decode(\"utf-8\")\n\n\ndef get_public_key(gh_base_url: str, gh_owner: str, gh_repo: str, gh_auth_token: str) -\u003e (str, str):\n    public_key_endpoint: str = f\"{gh_base_url}/{gh_owner}/{gh_repo}/actions/secrets/public-key\"\n    headers: TypedDict[str, str] = {\"Authorization\": f\"Bearer {gh_auth_token}\"}\n    response = requests.get(url=public_key_endpoint, headers=headers)\n    if response.status_code != 200:\n        raise IOError(\n            f\"Could not get public key for repository {gh_owner}/{gh_repo}. The Response code was {response.status_code}\")\n\n    public_key_json = response.json()\n    return public_key_json['key_id'], public_key_json['key']\n\n\ndef set_secret(gh_base_url: str, gh_owner: str, gh_repo: str, gh_auth_token: str, public_key_id: str, secret_key: str,\n               encrypted_secret_value: str):\n    secret_creation_url = f\"{gh_base_url}/{gh_owner}/{gh_repo}/actions/secrets/{secret_key}\"\n    secret_creation_body = {\"key_id\": public_key_id, \"encrypted_value\": encrypted_secret_value}\n    headers: TypedDict[str, str] = {\"Authorization\": f\"Bearer {gh_auth_token}\", \"Content-Type\": \"application/json\"}\n\n    secret_creation_response = requests.put(url=secret_creation_url, json=secret_creation_body, headers=headers)\n    if secret_creation_response.status_code == 201 or secret_creation_response.status_code == 204:\n        print(\"--Secret Created / Updated!--\")\n    else:\n        print(f\"-- Error creating / updating github secret, the reason was : {secret_creation_response.reason}\")\n\n\nparser, _ = init_argparse()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\ntoken = generate_github_token(parser.github_app_id, parser.github_app_private_key,\n                              parser.github_app_installation_id) if len(\n    parser.git_password.strip()) == 0 else parser.git_password.strip()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\nif not parser.secret_name.strip():\n    print(\"You must define the secret name\")\n    sys.exit(1)\n    \nif not verify_new_repo(token, parser.git_organization, parser.repo):\n    print(\"Could not find the repo\")\n    sys.exit(1)\n\nkey_id, public_key = get_public_key('https://api.github.com/repos', parser.git_organization, parser.repo,\n                                    token)\nencrypted_secret: str = encrypt(public_key_for_repo=public_key, secret_value_input=parser.secret_value)\nset_secret(gh_base_url='https://api.github.com/repos', gh_owner=parser.git_organization, gh_repo=parser.repo,\n           gh_auth_token=token, public_key_id=key_id, secret_key=parser.secret_name,\n           encrypted_secret_value=encrypted_secret)\n"
        "CreateGitHubSecret.Git.Url.Organization"     = "#{Git.Url.Organization}"
        "CreateGitHubSecret.GitHub.Secret.Name"       = "DOCKERHUB_USERNAME"
        "Octopus.Action.Script.Syntax"                = "Python"
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
  step {
    condition           = "Success"
    name                = "Generate and Push"
    package_requirement = "LetOctopusDecide"
    start_trigger       = "StartAfterPrevious"

    action {
      action_type                        = "Octopus.Script"
      name                               = "Generate and Push"
      condition                          = "Success"
      run_on_server                      = true
      is_disabled                        = false
      can_be_used_for_project_versioning = true
      is_required                        = false
      worker_pool_id                     = local.worker_pool_id
      properties                         = {
        "PopulateGithubRepo.Yeoman.Generator.SubGenerator" = "nodejs-docker-webapp"
        "PopulateGithubRepo.Yeoman.Generator.Arguments"    = "--octopusUrl #{Octopus.Action[Get Variables].Output.Web.ServerUri} --octopusSpace \"#{Octopus.Action[Get Variables].Output.Space.Name}\" --octopusApi #{Octopus.ApiKey} --octopusProject \"#{Application.Octopus.Project}\" --dockerImage #{Application.Docker.Image}"
        "PopulateGithubRepo.Yeoman.Generator.Name"         = "octopus-reference-architecture-apps"
        "Octopus.Action.Script.Syntax"                     = "Python"
        "Octopus.Action.Script.ScriptSource"               = "Inline"
        "Octopus.Action.Script.ScriptBody"                 = "# This script forks a GitHub repo. It creates a token from a GitHub App installation to avoid\n# having to use a regular user account.\nimport subprocess\nimport sys\n\n# Install our own dependencies\nenv_vars = os.environ.copy()\nenv_vars['PIP_ROOT_USER_ACTION'] = 'ignore'\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'jwt', '--disable-pip-version-check'], env=env_vars)\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'requests', '--disable-pip-version-check'], env=env_vars)\nsubprocess.check_call([sys.executable, '-m', 'pip', 'install', 'anyascii', '--disable-pip-version-check'], env=env_vars)\n\nimport requests\nimport json\nimport subprocess\nimport sys\nimport os\nimport urllib.request\nimport base64\nimport re\nimport jwt\nimport time\nimport argparse\nimport platform\nimport zipfile\nimport lzma\nimport tarfile\nimport shutil\nimport urllib3\nfrom shlex import split\nfrom anyascii import anyascii\n\n# Disable insecure http request warnings\nurllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)\n\n# If this script is not being run as part of an Octopus step, setting variables is a noop\nif 'set_octopusvariable' not in globals():\n    def set_octopusvariable(variable, value):\n        pass\n\n# If this script is not being run as part of an Octopus step, return variables from environment variables.\n# Periods are replaced with underscores, and the variable name is converted to uppercase\nif \"get_octopusvariable\" not in globals():\n    def get_octopusvariable(variable):\n        return os.environ[re.sub('\\\\.', '_', variable.upper())]\n\n# If this script is not being run as part of an Octopus step, print directly to std out.\nif 'printverbose' not in globals():\n    def printverbose(msg):\n        print(msg)\n\n\ndef printverbose_noansi(output):\n    \"\"\"\n    Strip ANSI color codes and print the output as verbose\n    :param output: The output to print\n    \"\"\"\n    output_no_ansi = re.sub(r'\\x1b\\[[0-9;]*m', '', output)\n    printverbose(output_no_ansi)\n\n\ndef get_octopusvariable_quiet(variable):\n    \"\"\"\n    Gets an octopus variable, or an empty string if it does not exist.\n    :param variable: The variable name\n    :return: The variable value, or an empty string if the variable does not exist\n    \"\"\"\n    try:\n        return get_octopusvariable(variable)\n    except Exception as inst:\n        return ''\n\n\ndef execute(args, cwd=None, env=None, print_args=None, print_output=printverbose_noansi, raise_on_non_zero=False,\n            append_to_path=None):\n    \"\"\"\n        The execute method provides the ability to execute external processes while capturing and returning the\n        output to std err and std out and exit code.\n    \"\"\"\n\n    my_env = os.environ.copy() if env is None else env\n\n    if append_to_path is not None:\n        my_env[\"PATH\"] = append_to_path + os.pathsep + my_env['PATH']\n\n    process = subprocess.Popen(args,\n                               stdout=subprocess.PIPE,\n                               stderr=subprocess.PIPE,\n                               stdin=open(os.devnull),\n                               text=True,\n                               cwd=cwd,\n                               env=my_env)\n    stdout, stderr = process.communicate()\n    retcode = process.returncode\n\n    if not retcode == 0 and raise_on_non_zero:\n        raise Exception('command returned exit code ' + retcode)\n\n    if print_args is not None:\n        print_output(' '.join(args))\n\n    if print_output is not None:\n        print_output(stdout)\n        print_output(stderr)\n\n    return stdout, stderr, retcode\n\n\ndef init_argparse():\n    parser = argparse.ArgumentParser(\n        usage='%(prog)s [OPTION]',\n        description='Fork a GitHub repo'\n    )\n    parser.add_argument('--generator', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Yeoman.Generator.Name') or get_octopusvariable_quiet(\n                            'Yeoman.Generator.Name'))\n    parser.add_argument('--sub-generator', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Yeoman.Generator.SubGenerator') or get_octopusvariable_quiet(\n                            'Yeoman.Generator.SubGenerator'))\n    parser.add_argument('--generator-arguments', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Yeoman.Generator.Arguments') or get_octopusvariable_quiet(\n                            'Yeoman.Generator.Arguments'),\n                        help='The arguments to pas to yo. Pass all arguments as a single string. This string is then parsed as if it were yo arguments.')\n    parser.add_argument('--repo', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Git.Url.Repo') or get_octopusvariable_quiet(\n                            'Git.Url.Repo'))\n    parser.add_argument('--git-organization', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Git.Url.Organization') or get_octopusvariable_quiet(\n                            'Git.Url.Organization'))\n    parser.add_argument('--github-app-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.GitHub.App.Id') or get_octopusvariable_quiet('GitHub.App.Id'))\n    parser.add_argument('--github-app-installation-id', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.GitHub.App.InstallationId') or get_octopusvariable_quiet(\n                            'GitHub.App.InstallationId'))\n    parser.add_argument('--github-app-private-key', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.GitHub.App.PrivateKey') or get_octopusvariable_quiet(\n                            'GitHub.App.PrivateKey'))\n    parser.add_argument('--git-password', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Git.Credentials.Password') or get_octopusvariable_quiet(\n                            'Git.Credentials.Password'),\n                        help='The git password. This takes precedence over the --github-app-id,  --github-app-installation-id, and --github-app-private-key')\n    parser.add_argument('--git-username', action='store',\n                        default=get_octopusvariable_quiet(\n                            'PopulateGithubRepo.Git.Credentials.Username') or get_octopusvariable_quiet(\n                            'Git.Credentials.Username'),\n                        help='The git username. This will be used for both the git authentication and the username associated with any commits.')\n\n    return parser.parse_known_args()\n\n\ndef generate_github_token(github_app_id, github_app_private_key, github_app_installation_id):\n    # Generate the tokens used by git and the GitHub API\n    app_id = github_app_id\n    signing_key = jwt.jwk_from_pem(github_app_private_key.encode('utf-8'))\n\n    payload = {\n        # Issued at time\n        'iat': int(time.time()),\n        # JWT expiration time (10 minutes maximum)\n        'exp': int(time.time()) + 600,\n        # GitHub App's identifier\n        'iss': app_id\n    }\n\n    # Create JWT\n    jwt_instance = jwt.JWT()\n    encoded_jwt = jwt_instance.encode(payload, signing_key, alg='RS256')\n\n    # Create access token\n    url = 'https://api.github.com/app/installations/' + github_app_installation_id + '/access_tokens'\n    headers = {\n        'Authorization': 'Bearer ' + encoded_jwt,\n        'Accept': 'application/vnd.github+json',\n        'X-GitHub-Api-Version': '2022-11-28'\n    }\n    request = urllib.request.Request(url, headers=headers, method='POST')\n    response = urllib.request.urlopen(request)\n    response_json = json.loads(response.read().decode())\n    return response_json['token']\n\n\ndef generate_auth_header(token):\n    auth = base64.b64encode(('x-access-token:' + token).encode('ascii'))\n    return 'Basic ' + auth.decode('ascii')\n\n\ndef verify_new_repo(token, cac_org, new_repo):\n    # Attempt to view the new repo\n    try:\n        url = 'https://api.github.com/repos/' + cac_org + '/' + new_repo\n        headers = {\n            'Accept': 'application/vnd.github+json',\n            'Authorization': 'Bearer ' + token,\n            'X-GitHub-Api-Version': '2022-11-28'\n        }\n        request = urllib.request.Request(url, headers=headers)\n        urllib.request.urlopen(request)\n        return True\n    except Exception as inst:\n        return False\n\n\ndef is_windows():\n    return platform.system() == 'Windows'\n\n\ndef download_file(url, filename, verify_ssl=True):\n    r = requests.get(url, verify=verify_ssl)\n    with open(filename, 'wb') as file:\n        file.write(r.content)\n\n\ndef ensure_git_exists():\n    if is_windows():\n        print(\"Checking git is installed\")\n        try:\n            stdout, _, exit_code = execute(['git', 'version'])\n            printverbose(stdout)\n            if not exit_code == 0:\n                raise \"git not found\"\n        except:\n            print(\"Downloading git\")\n            download_file('https://www.7-zip.org/a/7zr.exe', '7zr.exe')\n            download_file(\n                'https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/PortableGit-2.42.0.2-64-bit.7z.exe',\n                'PortableGit.7z.exe')\n            print(\"Installing git\")\n            print(\"Consider installing git on the worker or using a standard worker-tools image\")\n            execute(['7zr.exe', 'x', 'PortableGit.7z.exe', '-o' + os.path.join(os.getcwd(), 'git'), '-y'])\n            return os.path.join(os.getcwd(), 'git', 'bin', 'git')\n\n    return 'git'\n\n\ndef install_npm_linux():\n    print(\"Downloading node\")\n    download_file(\n        'https://nodejs.org/dist/v18.18.2/node-v18.18.2-linux-x64.tar.xz',\n        'node.tar.xz')\n    print(\"Installing node on Linux\")\n    with lzma.open(\"node.tar.xz\", \"r\") as lzma_ref:\n        with open(\"node.tar\", \"wb\") as fdst:\n            shutil.copyfileobj(lzma_ref, fdst)\n    with tarfile.open(\"node.tar\", \"r\") as tar_ref:\n        tar_ref.extractall(os.getcwd())\n\n    try:\n        _, _, exit_code = execute([os.getcwd() + '/node-v18.18.2-linux-x64/bin/npm', '--version'],\n                                  append_to_path=os.getcwd() + '/node-v18.18.2-linux-x64/bin')\n        if not exit_code == 0:\n            raise Exception(\"Failed to run npm\")\n    except Exception as ex:\n        print('Failed to install npm ' + str(ex))\n        sys.exit(1)\n    return os.getcwd() + '/node-v18.18.2-linux-x64/bin/npm', os.getcwd() + '/node-v18.18.2-linux-x64/bin'\n\n\ndef install_npm_windows():\n    print(\"Downloading node\")\n    download_file('https://nodejs.org/dist/v18.18.2/node-v18.18.2-win-x64.zip', 'node.zip', False)\n    print(\"Installing node on Windows\")\n    with zipfile.ZipFile(\"node.zip\", \"r\") as zip_ref:\n        zip_ref.extractall(os.getcwd())\n    try:\n        _, _, exit_code = execute([os.path.join(os.getcwd(), 'node-v18.18.2-win-x64', 'npm.cmd'), '--version'],\n                                  append_to_path=os.path.join(os.getcwd(), 'node-v18.18.2-win-x64'))\n        if not exit_code == 0:\n            raise Exception(\"Failed to run npm\")\n    except Exception as ex:\n        print('Failed to install npm ' + str(ex))\n        sys.exit(1)\n\n    return (os.path.join(os.getcwd(), 'node-v18.18.2-win-x64', 'npm.cmd'),\n            os.path.join(os.getcwd(), 'node-v18.18.2-win-x64'))\n\n\ndef ensure_node_exists():\n    try:\n        print(\"Checking node is installed\")\n        _, _, exit_code = execute(['npm', '--version'])\n        if not exit_code == 0:\n            raise Exception(\"npm not found\")\n    except:\n        if is_windows():\n            return install_npm_windows()\n        else:\n            return install_npm_linux()\n\n    return 'npm', None\n\n\ndef ensure_yo_exists(npm_executable, npm_path):\n    try:\n        print(\"Checking Yeoman is installed\")\n        _, _, exit_code = execute(['yo', '--version'])\n        if not exit_code == 0:\n            raise Exception(\"yo not found\")\n    except:\n        print('Installing Yeoman')\n\n        _, _, retcode = execute([npm_executable, 'install', '-g', 'yo'], append_to_path=npm_path)\n\n        if not retcode == 0:\n            print(\"Failed to set install Yeoman. Check the verbose logs for details.\")\n            sys.exit(1)\n\n        npm_bin, _, retcode = execute([npm_executable, 'config', 'get', 'prefix'], append_to_path=npm_path)\n\n        if not retcode == 0:\n            print(\"Failed to set get the npm prefix directory. Check the verbose logs for details.\")\n            sys.exit(1)\n\n        try:\n            if is_windows():\n                _, _, exit_code = execute([os.path.join(npm_bin.strip(), 'yo.cmd'), '--version'],\n                                          append_to_path=npm_path)\n            else:\n                _, _, exit_code = execute([os.path.join(npm_bin.strip(), 'bin', 'yo'), '--version'],\n                                          append_to_path=npm_path)\n\n            if not exit_code == 0:\n                raise Exception(\"Failed to run yo\")\n        except Exception as ex:\n            print('Failed to install yo ' + str(ex))\n            sys.exit(1)\n\n        # Windows and Linux save NPM binaries in different directories\n        if is_windows():\n            return os.path.join(npm_bin.strip(), 'yo.cmd')\n\n        return os.path.join(npm_bin.strip(), 'bin', 'yo')\n\n    return 'yo'\n\n\ngit_executable = ensure_git_exists()\nnpm_executable, npm_path = ensure_node_exists()\nyo_executable = ensure_yo_exists(npm_executable, npm_path)\nparser, _ = init_argparse()\n\nif not parser.git_password.strip() and not (\n        parser.github_app_id.strip() and parser.github_app_private_key.strip() and parser.github_app_installation_id.strip()):\n    print(\"You must supply the GitHub token, or the GitHub App ID and private key and installation ID\")\n    sys.exit(1)\n\nif not parser.git_organization.strip():\n    print(\"You must define the organization\")\n    sys.exit(1)\n\nif not parser.repo.strip():\n    print(\"You must define the repo name\")\n    sys.exit(1)\n\nif not parser.generator.strip():\n    print(\"You must define the Yeoman generator\")\n    sys.exit(1)\n\n# Create a dir for the git clone\nif os.path.exists('downstream'):\n    shutil.rmtree('downstream')\n\nos.mkdir('downstream')\n\n# Create a dir for yeoman to use\nif os.path.exists('downstream-yeoman'):\n    shutil.rmtree('downstream-yeoman')\n\nos.mkdir('downstream-yeoman')\n# Yeoman will use a less privileged user to write to this directory, so grant full access\nif not is_windows():\n    os.chmod('downstream-yeoman', 0o777)\n\ndownstream_dir = os.path.join(os.getcwd(), 'downstream')\ndownstream_yeoman_dir = os.path.join(os.getcwd(), 'downstream-yeoman')\n\n# The access token is generated from a github app or supplied directly as an access token\ntoken = generate_github_token(parser.github_app_id, parser.github_app_private_key,\n                              parser.github_app_installation_id) if len(\n    parser.git_password.strip()) == 0 else parser.git_password.strip()\n\nif not verify_new_repo(token, parser.git_organization, parser.repo):\n    print('Repo at https://github.com/' + parser.git_organization + '/' + parser.repo + ' could not be accessed')\n    sys.exit(1)\n\n# We need to disable the credentials helper prompt, which will pop open a GUI prompt that we can never close\nif is_windows():\n    _, _, retcode = execute([git_executable, 'config', '--system', 'credential.helper', 'manager'])\n\n    if not retcode == 0:\n        print(\"Failed to set the credential.helper setting. Check the verbose logs for details.\")\n        sys.exit(1)\n\n    _, _, retcode = execute([git_executable, 'config', '--system', 'credential.modalprompt', 'false'])\n\n    if not retcode == 0:\n        print(\"Failed to srt the credential.modalprompt setting. Check the verbose logs for details.\")\n        sys.exit(1)\n\n    # We need to disable the credentials helper prompt, which will pop open a GUI prompt that we can never close\n    _, _, retcode = execute(\n        [git_executable, 'config', '--system', 'credential.microsoft.visualstudio.com.interactive', 'never'])\n\n    if not retcode == 0:\n        print(\n            \"Failed to set the credential.microsoft.visualstudio.com.interactive setting. Check the verbose logs for details.\")\n        sys.exit(1)\n\n_, _, retcode = execute([git_executable, 'config', '--global', 'user.email', 'octopus@octopus.com'])\n\nif not retcode == 0:\n    print(\"Failed to set the user.email setting. Check the verbose logs for details.\")\n    sys.exit(1)\n\n_, _, retcode = execute([git_executable, 'config', '--global', 'core.autocrlf', 'input'])\n\nif not retcode == 0:\n    print(\"Failed to set the core.autocrlf setting. Check the verbose logs for details.\")\n    sys.exit(1)\n\nusername = parser.git_username if len(parser.git_username) != 0 else 'Octopus'\n_, _, retcode = execute([git_executable, 'config', '--global', 'user.name', username])\n\nif not retcode == 0:\n    print(\"Failed to set the git username. Check the verbose logs for details.\")\n    sys.exit(1)\n\n_, _, retcode = execute([git_executable, 'config', '--global', 'credential.helper', 'cache'])\n\nif not retcode == 0:\n    print(\"Failed to set the git credential helper. Check the verbose logs for details.\")\n    sys.exit(1)\n\nprint('Cloning repo')\n\n_, _, retcode = execute(\n    [git_executable, 'clone',\n     'https://' + username + ':' + token + '@github.com/' + parser.git_organization + '/' + parser.repo + '.git',\n     'downstream'])\n\nif not retcode == 0:\n    print(\"Failed to clone the git repo. Check the verbose logs for details.\")\n    sys.exit(1)\n\nprint('Configuring Yeoman Generator')\n\n_, _, retcode = execute([npm_executable, 'install'], cwd=os.path.join(os.getcwd(), 'YeomanGenerator'), append_to_path=npm_path)\n\nif not retcode == 0:\n    print(\"Failed to install the generator dependencies. Check the verbose logs for details.\")\n    sys.exit(1)\n\n_, _, retcode = execute([npm_executable, 'link'], cwd=os.path.join(os.getcwd(), 'YeomanGenerator'), append_to_path=npm_path)\n\nif not retcode == 0:\n    print(\"Failed to link the npm module. Check the verbose logs for details.\")\n    sys.exit(1)\n\nprint('Running Yeoman Generator')\n\n# Treat the string of yo arguments as a raw input and parse it again. The resulting list of unknown arguments\n# is then passed to yo. We have to convert the incoming values from utf to ascii when parsing a second time.\nyo_args = split(anyascii(parser.generator_arguments))\n\ngenerator_name = parser.generator + ':' + parser.sub_generator if len(parser.sub_generator) != 0 else parser.generator\n\nyo_arguments = [yo_executable, generator_name, '--force', '--skip-install']\n\n# Yeoman has issues running as root, which it will often do in a container.\n# So we run Yeoman in its own directory, and then copy the changes to the git directory.\n_, _, retcode = execute(yo_arguments + yo_args, cwd=downstream_yeoman_dir, append_to_path=npm_path)\n\nif not retcode == 0:\n    print(\"Failed to run Yeoman. Check the verbose logs for details.\")\n    sys.exit(1)\n\nshutil.copytree(downstream_yeoman_dir, downstream_dir, dirs_exist_ok=True)\n\nprint('Adding changes to git')\n\n_, _, retcode = execute([git_executable, 'add', '.'], cwd=downstream_dir)\n\nif not retcode == 0:\n    print(\"Failed to add the git changes. Check the verbose logs for details.\")\n    sys.exit(1)\n\n# Check for pending changes\n_, _, retcode = execute([git_executable, 'diff-index', '--quiet', 'HEAD'], cwd=downstream_dir)\n\nif not retcode == 0:\n    print('Committing changes to git')\n    _, _, retcode = execute([git_executable, 'commit', '-m',\n                             'Added files from Yeoman generator ' + parser.generator + ':' + parser.sub_generator],\n                            cwd=downstream_dir)\n\n    if not retcode == 0:\n        print(\"Failed to set commit the git changes. Check the verbose logs for details.\")\n        sys.exit(1)\n\n    print('Pushing changes to git')\n\n    _, _, retcode = execute([git_executable, 'push', 'origin', 'main'], cwd=downstream_dir)\n\n    if not retcode == 0:\n        print(\"Failed to push the git changes. Check the verbose logs for details.\")\n        sys.exit(1)\n"
        "PopulateGithubRepo.Yeoman.Generator.Package"      = jsonencode({
          "PackageId" = "OctopusSolutionsEngineering/ReferenceArchitectureAppGenerators"
          "FeedId"    = local.github_feed_id
        })
        "Octopus.Action.RunOnServer"                  = "true"
        "PopulateGithubRepo.Git.Url.Organization"     = "#{Git.Url.Organization}"
        "PopulateGithubRepo.Git.Url.Repo"             = "#{Octopus.Action[Create Repo].Output.NewRepo}"
        "PopulateGithubRepo.Git.Credentials.Password" = "#{Git.Credentials.Password}"
      }

      container {
        feed_id = local.docker_hub_feed_id
        image   = "octopussamples/node-workertools"
      }

      environments          = []
      excluded_environments = []
      channels              = []
      tenant_tags           = []

      package {
        name                      = "YeomanGenerator"
        package_id                = "OctopusSolutionsEngineering/ReferenceArchitectureAppGenerators"
        acquisition_location      = "Server"
        extract_during_deployment = false
        feed_id                   = local.github_feed_id
        properties                = {
          Extract       = "True", PackageParameterName = "PopulateGithubRepo.Yeoman.Generator.Package", Purpose = "",
          SelectionMode = "deferred"
        }
      }
      features = []
    }

    properties   = {}
    target_roles = []
  }
}
#endregion

#endregion
