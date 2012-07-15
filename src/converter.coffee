define ['cs!./defs'], (defs) ->
  class Converter
    convert: (obj) ->
      val = defs[obj.from].algos[obj.to](obj.value)
      Math.round(val * 1000000) / 1000000