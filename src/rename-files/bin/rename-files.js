#! /usr/bin/env node

const argv = require("yargs/yargs")(process.argv.slice(2))
  .options({
    files: {
      desc: "Pattern of files to rename",
      required: true,
      alias: "f",
      type: "string"
    },
    transform: {
      desc: "Transform pattern and text to replace it with",
      alias: "t",
      array: true,
      type: "string"
    },
    dry: {
      desc: "Print files without moving them",
      alias: "d",
      type: "boolean",
      default: false
    }
  })
  .help()
  .argv;
const glob = require("glob");
const fs = require("fs");
const path = require("path");

(async () => {
  const files = glob.globSync(argv.files, {
    cwd: process.cwd()
  });

  for (const file of files) {
    const pathToFile = path.dirname(file);
    const fileName = path.basename(file);
    const newName = argv.transform.reduce((result, transform) => {
      const [pattern, replacement] = transform.split("|");

      return result.replace(new RegExp(pattern, "g"), replacement);
    }, fileName);

    if (!argv.dry) {
      await fs.promises.rename(file, path.join(pathToFile, newName));
    }

    console.log(`${fileName} -> ${newName}`);
  }
})();
