define [], () ->
  class Converter
    algos:
      ms:
        kmh: (val) -> val * 3.6
      kmh: 
        ms: (val) -> val / 3.6

    convert: (obj) ->
      @algos[obj.from][obj.to](obj.value)