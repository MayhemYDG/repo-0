This repo was populated from the Yeoman generator at https://github.com/OctopusSolutionsEngineering/ReferenceArchitectureAppGenerators.

Check the image in the `Build and push Docker image` step in [build.yaml](.github/workflows/build.yaml), and once you are
satisfied that it is a unique image, set the `push` paramater to `true`. You then also remove the `if` property on the
`Create Octopus Release` step to enable release creation in Octopus.
