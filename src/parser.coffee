define ['underscore'], (_) ->
  class Parser
    aliases: 
      ms: ['ms',  'm/s', 'meters per second']
      kmh: ['kmh', 'kph', 'kilometers per hour']

    parse: (str) ->
      str = str?.toLowerCase()

      obj = from: '', to: '', value: ''

      return obj unless str

      @findFrom str, obj
      @findTo str, obj
      @findValue str, obj

      obj

    findValue: (str, obj) ->
      arr = str.match /(\d)+/
      obj.value = arr[0] if arr?.length

    findFrom: (str, obj) ->
      @findProp str, obj, 'from'

    findTo: (str, obj) ->
      @findProp str, obj, 'to'

    findProp: (str, obj, prop) ->
      arr = str.split /\s/

      # scan the parts
      _.find arr, (s) =>
        _.find @aliases, (list, unit) ->
          if _.contains list, s
            obj[prop] = unit unless prop == 'to' && obj.from == unit

      return if obj[prop]

      # scan the whole string
      _.find @aliases, (list, unit) ->
        _.find list, (alias) ->
          if str.indexOf(alias) != -1
            obj[prop] = unit unless prop == 'to' && obj.from == unit