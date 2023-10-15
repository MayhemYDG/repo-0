"use strict";
const path = require("path");
const assert = require("yeoman-assert");
const helpers = require("yeoman-test");

describe("generator-octopus-reference-architecture-apps:nodejs-docker-webapp", () => {
  beforeAll(() => {
    return helpers
      .run(path.join(__dirname, "../generators/nodejs-docker-webapp"))
      .withPrompts({ someAnswer: true });
  });

  it("creates files", () => {
    assert.file(["dummyfile.txt"]);
  });
});
