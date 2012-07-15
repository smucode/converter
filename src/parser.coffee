define ['underscore'], (_) ->
  class Parser
    aliases: 
      ms: ['m(p|/)?s', 'met(er|re)(s)? per second']
      kmh: ['k(m|p|mp)h', 'kilomet(er|re)(s)? per hour']

    parse: (str) ->
      str = str?.toLowerCase()

      obj = from: '', to: '', value: ''

      return obj unless str

      @findValue str, obj

      props = @findProps str
      obj.from = props[0]
      obj.to   = props[1]

      obj

    findValue: (str, obj) ->
      arr = str.match /(\d)+/
      obj.value = arr[0] if arr?.length

    findProps: (str) ->
      props = []
      _.each @aliases, (list, unit) ->
        _.each list, (alias) ->
          pos = str.search(alias)
          if pos != -1
            props[pos] = unit
      _.chain(props).compact().flatten().value()