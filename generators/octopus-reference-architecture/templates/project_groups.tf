#region Project Groups
data "octopusdeploy_project_groups" "ra" {
  ids          = []
  partial_name = local.project_group_name
  skip         = 0
  take         = 1
}

resource "octopusdeploy_project_group" "project_group_ra" {
  count       = length(data.octopusdeploy_project_groups.ra.project_groups) == 0 ? 1 : 0
  name        = local.project_group_name
  description = "${local.project_group_name} projects."
}

data "octopusdeploy_project_groups" "project_templates" {
  ids          = []
  partial_name = "Project Templates"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_project_group" "project_group_project_templates" {
  count       = length(data.octopusdeploy_project_groups.project_templates.project_groups) == 0 ? 1 : 0
  name        = "Project Templates"
  description = "Sample code project generators"
}
#endregion

