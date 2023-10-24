#region Worker Pools

data "octopusdeploy_worker_pools" "workerpool_hosted_ubuntu" {
  partial_name = "Hosted Ubuntu"
  ids          = null
  skip         = 0
  take         = 1
}
#endregion