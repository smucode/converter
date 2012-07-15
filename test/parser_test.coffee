define ['cs!../src/parser'], (Parser) ->
  
  p = new Parser
  
  asserter = (from, to) ->
    (str) ->
      o = p.parse str
      assert.equals o.from, from, str
      assert.equals o.to, to, str if to

  buster.testCase 'Parser'
    
    'should return empty object when parsing null': ->
      o = p.parse()
      refute o.from
      refute o.to
      refute o.value

    'should parse meters per second': ->
      assert_ms = asserter('ms')
      assert_ms 'ms'
      assert_ms 'ms derp'
      assert_ms 'MS'
      assert_ms 'm/s'
      assert_ms 'mps'
      assert_ms 'metre per second'
      assert_ms 'meter per second'
      assert_ms 'meters per second'
      assert_ms 'meters per second derp'

    'should parse knots': ->
      assert_ms = asserter('knot')
      assert_ms 'knot'
      assert_ms 'kt'
      assert_ms 'knots'
      assert_ms 'kts'

    'should parse kilometers per hour': ->
      assert_kmh = asserter('kmh')
      assert_kmh 'kmh'
      assert_kmh 'km/h'
      assert_kmh 'kph'
      assert_kmh 'kmph'
      assert_kmh 'kilometres per hour'
      assert_kmh 'kilometer per hour'
      assert_kmh 'kilometers per hour'

    'should parse the value': ->
      assert_value = (str, expected) ->
        o = p.parse str
        assert.equals o.value, expected

      assert_value '100', 100
      assert_value 'la di da 1 bla bla 200', 1

    'should support decimals': ->
      assert_value = (str, expected) ->
        o = p.parse str
        assert.equals o.value, expected

      assert_value '0.123', 0.123
      assert_value '10.1', 10.1
      assert_value 'la di da bla bla 20,1', 20.1


    'should parse ms as from and kmh as to': ->
      assert_ms_kmh = asserter('ms', 'kmh')
      
      assert_ms_kmh('ms kmh')
      assert_ms_kmh('please convert ms to kmh yes :)')
      assert_ms_kmh('please convert meters per second to kilometers per hour now')

    'should parse the entire object correctly': ->
      assert_all = (f, t, v, s) ->
        o = p.parse s
        assert.equals o.from,  f, s
        assert.equals o.to,    t, s
        assert.equals o.value, v, s

      assert_all 'ms',  'kmh', 1,    '1 ms to kmh'
      assert_all 'ms', 'kmh', '100', '100 ms to kmh'
      assert_all 'ms', 'kmh', '42',  'i have 42 ms but what is it in kilometers per hour?'
      assert_all 'kmh', 'ms', '10',  'please convert 10 kilometers per hour to meters per second'


