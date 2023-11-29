## Reference Architecture Apps

How to use:

```bash
git clone https://github.com/OctopusSolutionsEngineering/ReferenceArchitectureAppGenerators.git
cd ReferenceArchitectureAppGenerators
npm link .
cd /tmp
yo octopus-reference-architecture-apps:octopus-reference-architecture \
  --force \
  --skip-install \
  --projectGroupName "Azure Web App" \
  --infrastructureProjectName "_ Azure Web App Infrastructure" \
  --infrastructureProjectDescription "Runbooks to create and manage Azure Web Apps" \
  --infrastructureRunbookName "Create Web App" \
  --infrastructureRunbookDescription "Creates an Azure web app and the associated Octopus target" \
  --octopubFrontendProjectName "Azure WebApp Octopub Frontend" \
  --octopubFrontendProjectDescription "Deploys the Octopub Frontend app to an Azure Web App target" \
  --octopubProductsProjectName "Azure WebApp Octopub Products" \
  --octopubProductsProjectDescription "Deploys the Octopub Products app to an Azure Web App target" \
  --octopubAuditsProjectName "Azure WebApp Octopub Audits" \
  --octopubAuditsProjectDescription "Deploys the Octopub Audits app to an Azure Web App target" \
  --octopubOrchestrationProjectName "_ Deploy Azure Web App Octopub Stack" \
  --octopubOrchestrationProjectDescription "Deploys the full Octopub application stack" \
  --frontendHealthCheck "/index.html" \
  --productsHealthCheck "/health/products" \
  --auditsHealthCheck "/health/audits" \
  --smokeTestContainerImage "octopuslabs/azure-workertools" \
  --targetRole "Azure_Web_App_Reference_Architecture" \
  --smokeTestActionType "Octopus.AzurePowerShell" \
  --feedbackLink "https://octopus.com"
```
