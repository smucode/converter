define ['cs!../src/converter'], (Converter) ->
  
  c = new Converter

  assert_conversion = (from, from_val, to, to_val) ->
    val = c.convert from: from, to: to, value: from_val
    assert.equals val, to_val

  buster.testCase 'Converter'

    'converts ms to kmh': ->
      assert_conversion 'ms', 10, 'kmh', 36

    'converts kmh to ms': ->
      assert_conversion 'kmh', 36, 'ms', 10