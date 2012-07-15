define [], () -> 
  vars = 
    nautic_mile: 1.852

  defs = 
    ms:
      singular: 'meter per second'
      plural:   'meters per second'
      aliases: ['m(p|/)?s', 'met(er|re)(s)? per second']
      algos: 
        kmh:  (ms) -> ms * 3.6
        knot: (ms) ->
          kmh = defs.ms.algos.kmh ms
          defs.kmh.algos.knot kmh
    kmh:
      singular: 'kilometer per hour'
      plural:   'kilometers per hour'
      aliases: ['k(m|p|mp)h', 'kilomet(er|re)(s)? per hour']
      algos: 
        ms:   (kmh) -> kmh / 3.6
        knot: (kmh) -> kmh / vars.nautic_mile

    knot:
      singular: 'knot'
      plural: 'knots'
      aliases: ['k(no)?t(s)?']
      algos: 
        kmh: (knot) -> knot * vars.nautic_mile
        ms:  (knot) ->
          kmh = defs.knot.algos.kmh knot
          defs.kmh.algos.ms kmh