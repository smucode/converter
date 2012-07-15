define ['cs!../src/converter'], (Converter) ->
  
  c = new Converter

  assert_conversion = (from, from_val, to, to_val) ->
    val = c.convert from: from, to: to, value: from_val
    assert.equals val, to_val, "#{from_val}#{from} is #{to_val}#{to}"

  buster.testCase 'Converter'

    'converts ms to kmh': ->
      assert_conversion 'ms', 10, 'kmh', 36

    'converts kmh to ms': ->
      assert_conversion 'kmh', 36, 'ms', 10

    'should be the same': ->
      assert_conversion 'kmh', 10, 'kmh', 10

    'should convert various combos based off fps': ->
      units = ['ms', 'kmh', 'mph', 'knot', 'fps']
      vals = [
        [1,        3.6,      2.236936,   1.943844, 3.280840],
        [0.277778, 1,        0.621371,   0.539957, 0.911344],
        [0.44704,  1.609344, 1,          0.868976, 1.466667],
        [0.514444, 1.852,    1.150779,   1,        1.687810],
        [0.3048,   1.09728,  0.681818,   0.592484, 1]
      ]
      _.each vals, (col, col_idx) ->
        _.each col, (value, row_idx) ->
          from = units[col_idx]
          to = units[row_idx]
          assert_conversion from, 1, to, value

