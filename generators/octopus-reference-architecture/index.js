"use strict";
const Generator = require("yeoman-generator");
const chalk = require("chalk");
const yosay = require("yosay");

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
      required: true
    });
    this.option("productsHealthCheck", {
      type: String,
      required: true
    });
    this.option("auditsHealthCheck", {
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
        auditsHealthCheck: this.options.auditsHealthCheck
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
