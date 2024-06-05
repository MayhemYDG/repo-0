"use strict";
const Generator = require("yeoman-generator");
const chalk = require("chalk");
const yosay = require("yosay");

module.exports = class extends Generator {
  // Note: arguments and options should be defined in the constructor.
  constructor(args, opts) {
    super(args, opts);

    this.option("octopusUrl", { type: String, required: true });
    this.option("octopusApi", { type: String, required: true });
    this.option("octopusSpace", { type: String, required: true });
    this.option("octopusProject", { type: String, required: true });
    this.option("dockerImage", { type: String, required: true });

    this.log("Octopus URL: " + this.options.octopusUrl);
    this.log("Octopus Space: " + this.options.octopusSpace);
    this.log("Octopus Project: " + this.options.octopusProject);
    this.log("Docker Image: " + this.options.dockerImage);
  }

  prompting() {
    // Have Yeoman greet the user.
    this.log(
      yosay(
        `Welcome to the breathtaking ${chalk.red(
          "Octopus Reference Architecture Apps"
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
    console.log("CWD: " + process.cwd());
    this.fs.copyTpl(
      this.templatePath("**/*"),
      this.destinationPath(this.destinationRoot()),
      {
        octopusUrl: this.options.octopusUrl,
        octopusSpace: this.options.octopusSpace,
        dockerImage: this.options.dockerImage,
        octopusProject: this.options.octopusProject,
        generated: Date.now()
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
