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
    }
  });
