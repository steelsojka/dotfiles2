const NotificationCenter = require('node-notifier/notifiers/notificationcenter');
const notifier = new NotificationCenter();

const cp = require('child_process');
const log = require('../src/log');

function spawn(cmd, args) {
  return new Promise(resolve => {
    const ps = cp.spawn(cmd, args, { stdio: 'inherit', cwd: process.cwd() });

    ps.on('exit', () => resolve());
  });
}

module.exports = async (params) => {
  log(`Fetching from ${params.upstream}...`);
  await spawn('git', ['fetch', params.upstream]);

  const result = cp.execSync(`git rev-list --left-right --count ${params.upstream}/${params.branch}...HEAD`).toString();
  const [, behindCountString] = /\s*([0-9]+)\s*[0-9]+/.exec(result);
  const behindCount = parseInt(behindCountString, 10);

  if (!Number.isNaN(behindCount) && behindCount > 0) {
    log(`HEAD is ${behindCount} commits behind ${params.upstream}!`);
    if (params.notify) {
      notifier.notify({
        title: 'GIT Head Watcher',
        message: `Hello, ${params.repo} is ${behindCount} commits behind ${params.upstream}!`,
        sound: 'Funk'
      });
    }
  } else {
    log(`HEAD is up to date with ${params.upstream}.`);
  }
}
