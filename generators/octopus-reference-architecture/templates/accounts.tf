#region Accounts

#data "octopusdeploy_accounts" "aws_account" {
#  account_type = "AmazonWebServicesAccount"
#  ids          = []
#  partial_name = "AWS Account"
#  skip         = 0
#  take         = 1
#}
#
#variable "account_aws_access_key" {
#  type        = string
#  nullable    = false
#  sensitive   = false
#  description = "The AWS access key associated with the account AWS Account"
#}
#
#variable "account_aws_secret_key" {
#  type        = string
#  nullable    = false
#  sensitive   = true
#  description = "The AWS secret key associated with the account AWS Account"
#}
#
#resource "octopusdeploy_aws_account" "aws_account" {
#  count                             = length(data.octopusdeploy_accounts.aws_account.accounts) == 0 ? 1 : 0
#  name                              = "AWS Account"
#  description                       = ""
#  environments                      = []
#  tenant_tags                       = []
#  tenants                           = []
#  tenanted_deployment_participation = "Untenanted"
#  access_key                        = var.account_aws_access_key
#  secret_key                        = var.account_aws_secret_key
#}

#endregion
