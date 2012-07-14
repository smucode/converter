define ['cs!./parser', 'cs!./converter'], (Parser, Converter) ->
  class Annotator

    aliases: 
      'ms': 'meters per second'
      'kmh': 'kilometers per hour'

    constructor: ->
      @p = new Parser
      @c = new Converter

    annotate: (str) ->
      return "Ask me to convert something!" unless str

      obj = @p.parse str

      return "I am confused, what are you trying to convert to what?" unless obj.from && obj.to && obj.value

      val = @c.convert obj

      "#{obj.value} #{@aliases[obj.from]} is #{val} #{@aliases[obj.to]}"