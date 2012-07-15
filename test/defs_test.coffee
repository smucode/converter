define ['underscore', 'cs!../src/defs'], (_, defs) ->
  buster.testCase 'Defs'
    'all defs should have the required values': ->
      _.each defs, (o, key) ->
        assert.equals typeof o.plural,   'string', 'plural'
        assert.equals typeof o.singular, 'string', 'singular'
        assert.equals typeof o.algos,    'object', 'algos'
        assert.equals typeof o.aliases,  'object', 'aliases'

    'all defs should have algos for all other defs': ->
      keys = _.keys defs
      _.each keys, (key) ->
        _.each keys, (other_key) ->
          assert defs[key].algos[other_key], "#{key} should have algo for #{other_key}" unless key is other_key