define [], () -> 
  vars = 
    nautic_mile: 1.852
    mph_magic: 1.609344

  calc_via_kmh = (from, to, val) ->
    kmh = defs[from].algos.kmh val
    defs.kmh.algos[to] kmh

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
        knot: (ms) -> calc_via_kmh 'ms', 'knot', ms
        mph:  (ms) -> calc_via_kmh 'ms', 'mph', ms

    knot:
      singular: 'knot'
      plural: 'knots'
      aliases: ['k(no)?t(s)?']
      algos: 
        kmh: (knot) -> knot * vars.nautic_mile
        ms:  (knot) -> calc_via_kmh 'knot', 'ms', knot
        mph: (knot) -> calc_via_kmh 'knot', 'mph', knot

    mph: 
      singular: 'mile per hour'
      plural: 'miles per hour'
      aliases: ['mph', 'mile(s)? per hour']
      algos: 
        kmh:  (mph) -> mph * vars.mph_magic
        ms:   (mph) -> calc_via_kmh 'mph', 'ms', mph
        knot: (mph) -> calc_via_kmh 'mph', 'knot', mph



