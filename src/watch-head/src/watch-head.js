const NotificationCenter = require("node-notifier/notifiers/notificationcenter");
const notifier = new NotificationCenter();

const cp = require("child_process");
const log = require("../src/log");

function spawn(cmd, args, env = {}) {
  return new Promise((resolve) => {
    console.log(`[spawn] ${cmd} ${args.join(" ")}`);

    const ps = cp.spawn(cmd, args, {
      stdio: "inherit",
      cwd: process.cwd(),
      env: {
        ...process.env,
        ...env,
      },
    });

    ps.on("exit", () => resolve());
  });
}

function exec(cmd) {
  console.log(`[exec] ${cmd}`);

  return cp.execSync(cmd).toString();
}

module.exports = async (params) => {
  log(`Fetching from ${params.upstream}...`);
  await spawn("git", ["fetch", params.upstream]);

  const result = exec(
    `git rev-list --left-right --count ${params.upstream}/${params.branch}...HEAD`,
  );
  const [, behindCountString] = /\s*([0-9]+)\s*[0-9]+/.exec(result);
  const behindCount = parseInt(behindCountString, 10);

  if (!Number.isNaN(behindCount) && behindCount > 0) {
    log(`HEAD is ${behindCount} commits behind ${params.upstream}!`);

    if (params.notify) {
      notifier.notify({
        title: "GIT Head Watcher",
        message: `Hello, ${params.repo} is ${behindCount} commits behind ${params.upstream}!`,
        sound: "Funk",
      });
    }

    if (params.update) {
      const pushParams = ["push", ...(params.noVerify ? ["--no-verify"] : [])];

      if (params.strategy === "rebase") {
        await spawn("git", ["rebase", `${params.upstream}/${params.branch}`]);
        pushParams.push("--force");
      } else if (params.strategy === "merge") {

        await spawn(
          "git",
          [
            "merge",
            `${params.upstream}/${params.branch}`,
            "--no-edit",
            ...(params.mergeMsg ? ["-m", `"${mergeMsg}"`] : []),
          ],
          {
            GIT_MERGE_AUTOEDIT: "no",
          },
        );
      }

      if (params.push) {
        await spawn("git", pushParams);
      }
    }
  } else {
    log(`HEAD is up to date with ${params.upstream}.`);
  }
};
