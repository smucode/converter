define ['cs!./parser', 'cs!./converter', 'cs!./defs'], (Parser, Converter, defs) ->
  class Annotator

    constructor: ->
      @p = new Parser
      @c = new Converter

    annotate: (str) ->
      return "Ask me to convert something!" unless str

      obj = @p.parse str

      return "I am confused, what are you trying to convert to what?" unless obj.from && obj.to && obj.value

      val = @c.convert obj

      "#{obj.value} #{@getUnit(obj.from, obj.value)} is #{val} #{@getUnit(obj.to, val)}"

    getUnit: (unit, val) ->
      if val is 1
        defs[unit].singular
      else
        defs[unit].plural