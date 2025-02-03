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
    strategy: {
      type: 'string',
      default: 'rebase'
    },
    update: {
      type: 'boolean',
      default: true
    },
    push: {
      type: 'boolean',
      default: false
    },
    noVerify: {
      type: 'boolean',
      default: true
    },
    mergeMsg: {
      type: 'string',
      default: ''
    }
  });
