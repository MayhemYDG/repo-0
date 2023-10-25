#region Locals
locals {
  /*
    You will need to edit:
    * smoke_test_properties - depending on the step type, custom properties will need to be defined
    * smoke_test_script - replace REPLACE THIS WITH CODE TO RETURN THE PUBLIC HOSTNAME with the appropriate logic
    * cloud_account - this will need to be created in most cases
    * security_scan_docker_script - the reference to the docker image deployed in earlier steps needs to be updated from #{Octopus.Action[Deploy Container].Package[web].PackageId}
    * octopusdeploy_deployment_process - each of the sample application deployment processes (there are 3 defined in this template) needs to have the actual deployment step added
  */


  project_group_name                        = "<%= projectGroupName %>"
  infrastructure_project_name               = "<%= infrastructureProjectName %>"
  infrastructure_project_description        = "<%= infrastructureProjectDescription %>"
  infrastructure_runbook_name               = "<%= infrastructureRunbookName %>"
  infrastructure_runbook_description        = "<%= infrastructureRunbookDescription %>"
  feedback_link                             = "<%= feedbackLink %>"
  octopub_frontend_project_name             = "<%= octopubFrontendProjectName %>"
  octopub_frontend_project_description      = "<%= octopubFrontendProjectDescription %>"
  octopub_products_project_name             = "<%= octopubProductsProjectName %>"
  octopub_products_project_description      = "<%= octopubProductsProjectDescription %>"
  octopub_audits_project_name               = "<%= octopubAuditsProjectName %>"
  octopub_audits_project_description        = "<%= octopubAuditsProjectDescription %>"
  octopub_orchestration_project_name        = "<%= octopubOrchestrationProjectName %>"
  octopub_orchestration_project_description = "<%= octopubOrchestrationProjectDescription %>"
  frontend_health_check                     = "<%= frontendHealthCheck %>"
  products_health_check                     = "<%= productsHealthCheck %>"
  audits_health_check                       = "<%= auditsHealthCheck %>"

  // Use the example below for any accounts that might be included in this reference architecture
  //cloud_account                        = length(data.octopusdeploy_accounts.account.accounts) == 0 ? octopusdeploy_aws_account.account[0].id : data.octopusdeploy_accounts.account.accounts[0].id

  development_environment_id         = length(data.octopusdeploy_environments.environment_development.environments) == 0 ? octopusdeploy_environment.environment_development[0].id : data.octopusdeploy_environments.environment_development.environments[0].id
  test_environment_id                = length(data.octopusdeploy_environments.environment_test.environments) == 0 ? octopusdeploy_environment.environment_test[0].id : data.octopusdeploy_environments.environment_test.environments[0].id
  production_environment_id          = length(data.octopusdeploy_environments.environment_production.environments) == 0 ? octopusdeploy_environment.environment_production[0].id : data.octopusdeploy_environments.environment_production.environments[0].id
  sync_environment_id                = length(data.octopusdeploy_environments.environment_sync.environments) == 0 ? octopusdeploy_environment.environment_sync[0].id : data.octopusdeploy_environments.environment_sync.environments[0].id
  security_environment_id            = length(data.octopusdeploy_environments.environment_security.environments) == 0 ? octopusdeploy_environment.environment_security[0].id : data.octopusdeploy_environments.environment_security.environments[0].id
  this_instance_library_variable_set = length(data.octopusdeploy_library_variable_sets.this_instance.library_variable_sets) == 0 ? octopusdeploy_library_variable_set.this_instance[0].id : data.octopusdeploy_library_variable_sets.this_instance.library_variable_sets[0].id
  github_library_variable_set        = length(data.octopusdeploy_library_variable_sets.github.library_variable_sets) == 0 ? octopusdeploy_library_variable_set.github[0].id : data.octopusdeploy_library_variable_sets.github.library_variable_sets[0].id
  docker_library_variable_set        = length(data.octopusdeploy_library_variable_sets.docker.library_variable_sets) == 0 ? octopusdeploy_library_variable_set.docker[0].id : data.octopusdeploy_library_variable_sets.docker.library_variable_sets[0].id
  docker_hub_feed_id                 = length(data.octopusdeploy_feeds.dockerhub.feeds) == 0 ? octopusdeploy_docker_container_registry.docker_hub[0].id : data.octopusdeploy_feeds.dockerhub.feeds[0].id
  github_feed_id                     = length(data.octopusdeploy_feeds.github_feed.feeds) == 0 ? octopusdeploy_github_repository_feed.github_feed[0].id : data.octopusdeploy_feeds.github_feed.feeds[0].id
  worker_pool_id                     = length(data.octopusdeploy_worker_pools.workerpool_hosted_ubuntu.worker_pools) == 0 ? "" : data.octopusdeploy_worker_pools.workerpool_hosted_ubuntu.worker_pools[0].id
  devops_lifecycle_id                = length(data.octopusdeploy_lifecycles.devsecops.lifecycles) == 0 ? octopusdeploy_lifecycle.lifecycle_devsecops[0].id : data.octopusdeploy_lifecycles.devsecops.lifecycles[0].id
  project_group_id                   = length(data.octopusdeploy_project_groups.ra.project_groups) == 0 ? octopusdeploy_project_group.project_group_ra[0].id : data.octopusdeploy_project_groups.ra.project_groups[0].id
  project_templates_project_group_id = length(data.octopusdeploy_project_groups.project_templates.project_groups) == 0 ? octopusdeploy_project_group.project_group_project_templates[0].id : data.octopusdeploy_project_groups.project_templates.project_groups[0].id
  application_lifecycle_id           = length(data.octopusdeploy_lifecycles.application.lifecycles) == 0 ? octopusdeploy_lifecycle.lifecycle_application[0].id : data.octopusdeploy_lifecycles.application.lifecycles[0].id
  smoke_test_container_image         = "<%= smokeTestContainerImage %>"
  smoke_test_action_type             = "<%= smokeTestActionType %>"
  smoke_test_properties              = {
    "Octopus.Action.RunOnServer"         = "true"
    "Octopus.Action.Script.ScriptSource" = "Inline"
    "Octopus.Action.Script.Syntax"       = "Bash"
    "Octopus.Action.Script.ScriptBody"   = local.smoke_test_script
    // Depending on the step type, you'll likely need some additional properties here like an Azure or AWS account
    //"OctopusUseBundledTooling": "False"
    //"Octopus.Action.Azure.AccountId": local.cloud_account
  }
  target_role                 = "<%= targetRole %>"
  feedback_script             = <<-EOT
  Write-Highlight "Please share your feedback on this step in our [GitHub discussion](${local.feedback_link})."
  EOT
  smoke_test_script           = <<-EOT
  for i in {1..30}
  do
    HOSTNAME=$(REPLACE THIS WITH CODE TO RETURN THE PUBLIC HOSTNAME)
      if [[ -n "$${HOSTNAME}" ]]
      then
        break
      fi
      echo "Waiting for ingress hostname"
      sleep 10
  done


  # Load balancers can take a minute or so before their DNS is propagated.
  # A status code of 000 means curl could not resolve the DNS name, so we wait for a bit until DNS is updated.
  echo "Testing http://$${HOSTNAME}#{App.HealthCheck}"
  echo "Waiting for DNS to propagate. This can take a while for a new load balancer."
  for i in {1..30}
  do
    CODE=$(curl -o /dev/null -s -w "%%{http_code}\n" http://$${HOSTNAME}#{App.HealthCheck})
    if [[ "$${CODE}" == "200" ]]
    then
      break
    fi
    echo "Waiting for DNS name to be resolvable and for service to respond"
    sleep 10
  done

  echo "response code: $${CODE}"
  if [[ "$${CODE}" == "200" ]]
  then
      echo "success"
      exit 0
  else
      echo "error"
      exit 1
  fi
  EOT
  security_scan_docker_script = <<-EOT
  echo "Pulling Trivy Docker Image"
  echo "##octopus[stdout-verbose]"
  docker pull aquasec/trivy
  echo "##octopus[stdout-default]"

  echo "Installing umoci"
  echo "##octopus[stdout-verbose]"
  # Install umoci
  if ! which umoci
  then
    curl -o umoci -L https://github.com/opencontainers/umoci/releases/latest/download/umoci.amd64 2>&1
    chmod +x umoci
  fi
  echo "##octopus[stdout-default]"

  DOCKERIMAGE=#{Octopus.Action[Deploy Container].Package[web].PackageId}
  DOCKERTAG=#{Octopus.Action[Deploy Container].Package[web].PackageVersion}

  echo "Extracting Application Docker Image"
  echo "##octopus[stdout-verbose]"
  # Download and extract the docker image
  # https://manpages.ubuntu.com/manpages/jammy/man1/umoci-raw-unpack.1.html
  docker pull quay.io/skopeo/stable:latest 2>&1
  docker run -v $(pwd):/output quay.io/skopeo/stable:latest copy docker://$${DOCKERIMAGE}:$${DOCKERTAG} oci:/output/image:latest 2>&1
  ./umoci unpack --image image --rootless bundle 2>&1
  echo "##octopus[stdout-default]"

  TIMESTAMP=$(date +%s%3N)
  SUCCESS=0
  for x in $(find . -name bom.json -type f -print); do
      echo "Scanning $${x}"

      # Delete any existing report file
      if [[ -f "$PWD/depscan-bom.json" ]]; then
        rm "$PWD/depscan-bom.json"
      fi

      # Generate the report, capturing the output, and ensuring $? is set to the exit code
      OUTPUT=$(bash -c "docker run --rm -v \"$PWD:/app\" aquasec/trivy sbom \"/app/$${x}\"; exit \$?" 2>&1)

      # Success is set to 1 if the exit code is not zero
      if [[ $? -ne 0 ]]; then
          SUCCESS=1
      fi

      # Print the output stripped of ANSI colour codes
      echo -e "$${OUTPUT}" | sed 's/\x1b\[[0-9;]*m//g'
  done

  set_octopusvariable "VerificationResult" $SUCCESS

  if [[ $SUCCESS -ne 0 ]]; then
    >&2 echo "Critical vulnerabilities were detected"
  fi

  exit 0
  EOT
}
#endregion
