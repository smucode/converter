define ['underscore', 'cs!./defs'], (_, defs) ->
  class Parser

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
      arr = str.match /(\d)+([\.,](\d))*/
      obj.value = parseFloat(arr[0]?.replace(',', '.'), 10) if arr?.length

    findProps: (str) ->
      props = []
      _.each defs, (o, unit) ->
        _.each o.aliases, (alias) ->
          pos = str.search(alias)
          if pos != -1
            props[pos] = unit
      _.chain(props).compact().flatten().value()