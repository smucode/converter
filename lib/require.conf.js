require.config({
  paths: {
    'cs': 'lib/cs',
    'underscore': 'lib/underscore',
    'coffee-script': 'lib/coffee-script'
  },
  shim: {
    'underscore': {
      exports: '_'
    }
  }
});