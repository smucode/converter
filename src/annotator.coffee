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

      "#{obj.value} #{defs[obj.from].plural} is #{val} #{defs[obj.to].plural}"