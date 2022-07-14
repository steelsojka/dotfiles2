const { spawn } = require('child_process')

module.exports = (serverPath, ...args) => {
  spawn('node', [serverPath, '--stdio', ...args], { stdio: 'inherit' })
}
