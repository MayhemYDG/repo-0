"use strict";
const Generator = require("yeoman-generator");
const chalk = require("chalk");
const yosay = require("yosay");

/*
The command below is an example of how to run the generator:

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
 */

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    this.option("projectGroupName", { type: String, required: true });
    this.option("infrastructureProjectName", { type: String, required: true });
    this.option("infrastructureProjectDescription", {
      type: String,
      required: true
    });
    this.option("infrastructureRunbookName", { type: String, required: true });
    this.option("infrastructureRunbookDescription", {
      type: String,
      required: true
    });
    this.option("feedbackLink", { type: String, required: true });
    this.option("octopubFrontendProjectName", { type: String, required: true });
    this.option("octopubFrontendProjectDescription", {
      type: String,
      required: true
    });
    this.option("octopubProductsProjectName", { type: String, required: true });
    this.option("octopubProductsProjectDescription", {
      type: String,
      required: true
    });
    this.option("octopubAuditsProjectName", { type: String, required: true });
    this.option("octopubAuditsProjectDescription", {
      type: String,
      required: true
    });
    this.option("octopubOrchestrationProjectName", {
      type: String,
      required: true
    });
    this.option("octopubOrchestrationProjectDescription", {
      type: String,
      required: true
    });
    this.option("frontendHealthCheck", {
      type: String,
      required: true,
      default: "/index.html"
    });
    this.option("productsHealthCheck", {
      type: String,
      required: true,
      default: "/health/products"
    });
    this.option("auditsHealthCheck", {
      type: String,
      required: true,
      default: "/health/audits"
    });
    this.option("smokeTestContainerImage", {
      type: String,
      required: true,
      description:
        "Pick an image from https://octopushq.atlassian.net/wiki/spaces/SE/pages/2713224189/Octopus+Labs+container+images to run the step in"
    });
    this.option("targetRole", {
      type: String,
      required: true
    });
    this.option("smokeTestActionType", {
      type: String,
      required: true
    });
  }

  prompting() {
    // Have Yeoman greet the user.
    this.log(
      yosay(
        `Welcome to the unreal ${chalk.red(
          "generator-reference-architecture-base"
        )} generator!`
      )
    );

    const prompts = [];

    return this.prompt(prompts).then(props => {
      // To access props later use this.props.someAnswer;
      this.props = props;
    });
  }

  writing() {
    this.fs.copyTpl(
      this.templatePath("**/*"),
      this.destinationPath(this.destinationRoot()),
      {
        projectGroupName: this.options.projectGroupName,
        infrastructureProjectName: this.options.infrastructureProjectName,
        infrastructureProjectDescription: this.options
          .infrastructureProjectDescription,
        infrastructureRunbookName: this.options.infrastructureRunbookName,
        infrastructureRunbookDescription: this.options
          .infrastructureRunbookDescription,
        feedbackLink: this.options.feedbackLink,
        octopubFrontendProjectName: this.options.octopubFrontendProjectName,
        octopubFrontendProjectDescription: this.options
          .octopubFrontendProjectDescription,
        octopubProductsProjectName: this.options.octopubProductsProjectName,
        octopubProductsProjectDescription: this.options
          .octopubProductsProjectDescription,
        octopubAuditsProjectName: this.options.octopubAuditsProjectName,
        octopubAuditsProjectDescription: this.options
          .octopubAuditsProjectDescription,
        octopubOrchestrationProjectName: this.options
          .octopubOrchestrationProjectName,
        octopubOrchestrationProjectDescription: this.options
          .octopubOrchestrationProjectDescription,
        frontendHealthCheck: this.options.frontendHealthCheck,
        productsHealthCheck: this.options.productsHealthCheck,
        auditsHealthCheck: this.options.auditsHealthCheck,
        smokeTestContainerImage: this.options.smokeTestContainerImage,
        targetRole: this.options.targetRole,
        smokeTestActionType: this.options.smokeTestActionType
      },
      null,
      {
        globOptions: {
          dot: true,
          ignore: [this.templatePath("node_modules/**/*")]
        }
      }
    );
  }

  install() {
    this.installDependencies();
  }
};
