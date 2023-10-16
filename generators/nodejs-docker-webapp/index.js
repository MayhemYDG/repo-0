"use strict";
const Generator = require("yeoman-generator");
const chalk = require("chalk");
const yosay = require("yosay");

module.exports = class extends Generator {
  // note: arguments and options should be defined in the constructor.
  constructor(args, opts) {
    super(args, opts);

    this.argument("octopusUrl", { type: String, required: true });
    this.argument("octopusApi", { type: String, required: true });
    this.argument("octopusSpace", { type: String, required: true });


    this.log("Octopus URL: " + this.options.octopusUrl);
    this.log("Octopus Space: " + this.options.octopusSpace);
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
      null,
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
