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
      # mps
      # metre per second
      # meter per second
      assert_ms 'meters per second'
      assert_ms 'meters per second derp'

    'should parse kilometers per hour': ->
      assert_kmh = asserter('kmh')

      assert_kmh 'kmh'
      assert_kmh 'kph'
      # kmph
      # kilometre/s per hour
      # kilometer/s per hour
      assert_kmh 'kilometers per hour'

    'should parse the value': ->
      assert_value = (str, expected) ->
        o = p.parse str
        assert.equals o.value, expected

      assert_value '100', 100
      assert_value 'la di da 1 bla bla 200', 1

    'should parse ms as from and kmh as to': ->
      assert_ms_kmh = asserter('ms', 'kmh')
      
      assert_ms_kmh('ms kmh')
      assert_ms_kmh('please convert ms to kmh yes :)')
      assert_ms_kmh('please convert meters per second to kilometers per hour now')

    'should parse ms as from and kmh as to and correct value': ->
      assert_all = (str, value) ->
        o = p.parse str
        assert.equals o.from, 'ms', str
        assert.equals o.to, 'kmh', str
        assert.equals o.value, value, str

      assert_all('100 ms to kmh', 100)
      assert_all('i have 42 ms but what is it in kilometers per hour?', 42)



