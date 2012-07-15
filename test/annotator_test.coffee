define ['cs!../src/annotator'], (Annotator) ->
  
  a = new Annotator

  buster.testCase 'Annotator'

    'should explain what to do when nothing has been entered': ->
      msg = a.annotate()
      assert.equals msg, 'Ask me to convert something!'
    
    'should convert ms to kmh': ->
      msg = a.annotate 'convert 10 ms to kmh'
      assert.equals msg, '10 meters per second is 36 kilometers per hour'  

    'should respond when it is confised': ->
      msg = a.annotate 'to mama'
      assert.equals msg, 'I am confused, what are you trying to convert to what?'

    'should respond in singular and plural': ->
      assert.equals a.annotate('1 ms kmh'), '1 meter per second is 3.6 kilometers per hour'
      assert.equals a.annotate('2 ms kmh'), '2 meters per second is 7.2 kilometers per hour'
