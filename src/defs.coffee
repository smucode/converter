define [], () -> 
  vars = 
    nautic_mile: 1.852
    mph_magic: 1.609344

  defs = 
    kmh:
      singular: 'kilometer per hour'
      plural:   'kilometers per hour'
      aliases: ['k(m|p|mp)h', 'kilomet(er|re)(s)? per hour']
      algos: 
        ms:   (kmh) -> kmh / 3.6
        knot: (kmh) -> kmh / vars.nautic_mile
        mph:  (kmh) -> kmh / vars.mph_magic

    ms:
      singular: 'meter per second'
      plural:   'meters per second'
      aliases: ['m(p|/)?s', 'met(er|re)(s)? per second']
      algos: 
        kmh:  (ms) -> ms * 3.6
        knot: (ms) ->
          kmh = defs.ms.algos.kmh ms
          defs.kmh.algos.knot kmh
        mph: (ms)  ->
          kmh = defs.ms.algos.kmh ms
          defs.kmh.algos.mph kmh

    knot:
      singular: 'knot'
      plural: 'knots'
      aliases: ['k(no)?t(s)?']
      algos: 
        kmh: (knot) -> knot * vars.nautic_mile
        ms:  (knot) ->
          kmh = defs.knot.algos.kmh knot
          defs.kmh.algos.ms kmh
        mph: (knot) ->
          kmh = defs.knot.algos.kmh knot
          defs.kmh.algos.mph kmh

    mph: 
      singular: 'mile per hour'
      plural: 'miles per hour'
      aliases: ['mph', 'mile(s)? per hour']
      algos: 
        kmh:  (mph) -> mph * vars.mph_magic
        ms:   (mph) ->
          kmh = defs.mph.algos.kmh mph
          defs.kmh.algos.ms kmh
        knot: (mph) ->
          kmh = defs.mph.algos.knot knot
          defs.kmh.algos.knot kmh
