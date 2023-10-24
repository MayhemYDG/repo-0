#region Feeds

data "octopusdeploy_feeds" "project" {
  feed_type = "OctopusProject"
  ids       = []
  skip      = 0
  take      = 1
}

data "octopusdeploy_feeds" "bitnami" {
  feed_type    = "Helm"
  ids          = []
  partial_name = "Bitnami"
  skip         = 0
  take         = 1
}


resource "octopusdeploy_helm_feed" "feed_helm" {
  count                                = length(data.octopusdeploy_feeds.bitnami.feeds) == 0 ? 1 : 0
  name                                 = "Bitnami"
  feed_uri                             = "https://repo.vmware.com/bitnami-files/"
  package_acquisition_location_options = ["ExecutionTarget", "NotAcquired"]
}

data "octopusdeploy_feeds" "dockerhub" {
  feed_type    = "Docker"
  ids          = []
  partial_name = "Docker Hub"
  skip         = 0
  take         = 1
}

variable "feed_docker_hub_username" {
  type        = string
  nullable    = false
  sensitive   = true
  description = "The username used by the feed Docker Hub"
}

variable "feed_docker_hub_password" {
  type        = string
  nullable    = false
  sensitive   = true
  description = "The password used by the feed Docker Hub"
}

resource "octopusdeploy_docker_container_registry" "docker_hub" {
  count                                = length(data.octopusdeploy_feeds.dockerhub.feeds) == 0 ? 1 : 0
  name                                 = "Docker Hub"
  password                             = var.feed_docker_hub_password
  username                             = var.feed_docker_hub_username
  api_version                          = "v1"
  feed_uri                             = "https://index.docker.io"
  package_acquisition_location_options = ["ExecutionTarget", "NotAcquired"]
}

data "octopusdeploy_feeds" "sales_maven_feed" {
  feed_type    = "Maven"
  ids          = []
  partial_name = "Sales Maven Feed"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_maven_feed" "feed_sales_maven_feed" {
  count                                = length(data.octopusdeploy_feeds.sales_maven_feed.feeds) == 0 ? 1 : 0
  name                                 = "Sales Maven Feed"
  feed_uri                             = "https://octopus-sales-public-maven-repo.s3.ap-southeast-2.amazonaws.com/snapshot"
  package_acquisition_location_options = ["Server", "ExecutionTarget"]
  download_attempts                    = 3
  download_retry_backoff_seconds       = 20
}

data "octopusdeploy_feeds" "github_feed" {
  feed_type    = "GitHub"
  ids          = []
  partial_name = "Github Releases"
  skip         = 0
  take         = 1
}

resource "octopusdeploy_github_repository_feed" "github_feed" {
  count                          = length(data.octopusdeploy_feeds.github_feed.feeds) == 0 ? 1 : 0
  download_attempts              = 1
  download_retry_backoff_seconds = 30
  feed_uri                       = "https://api.github.com"
  name                           = "Github Releases"
}
#endregion