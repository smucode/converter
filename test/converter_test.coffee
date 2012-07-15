define ['cs!../src/converter'], (Converter) ->
  
  c = new Converter

  class CX
    constructor: (from, value) ->
      @from = from
      @value = value
    to: (to) ->
      @value = c.convert from: @from, to: to, value: @value
      @from = to
      return @
    val: () -> @value


  assert_conversion = (from, from_val, to, to_val) ->
    val = c.convert from: from, to: to, value: from_val
    assert.equals val, to_val

  buster.testCase 'Converter'

    'converts ms to kmh': ->
      assert_conversion 'ms', 10, 'kmh', 36

    'converts kmh to ms': ->
      assert_conversion 'kmh', 36, 'ms', 10

    'should round to two digits': ->
      assert_conversion 'kmh', 10, 'ms', 2.78

    'should be the same': ->
      assert_conversion 'kmh', 10, 'kmh', 10

    'should support circular conversions': ->
      expected = 3.6
      actual = new CX('kmh', expected).to('knot').to('ms').to('kmh').val()
      assert.equals actual, expected

      actual = new CX('kmh', expected).to('knot').to('ms').to('mph').to('kmh').val()
      assert.equals actual, expected

      actual = new CX('kmh', expected).to('knot').to('fps').to('ms').to('mph').to('kmh').val()
      assert.equals actual, expected