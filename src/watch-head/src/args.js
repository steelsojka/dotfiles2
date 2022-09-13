module.exports = require('yargs')
  .options({
    repo: {
      type: 'string'
    },
    upstream: {
      type: 'string',
      default: 'upstream'
    },
    branch: {
      type: 'string',
      default: 'main'
    },
    notify: {
      type: 'boolean',
      default: true
    },
    rebase: {
      type: 'boolean',
      default: false
    },
    push: {
      type: 'boolean',
      default: false
    },
    noVerify: {
      type: 'boolean',
      default: true
    }
  });
