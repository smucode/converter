define [], () -> 
  vars = 
    nautic_mile: 1.852
    mph_magic: 1.609344
    fps_magic: 0.277778

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
        fps:  (kmh) -> kmh / vars.fps_magic

    ms:
      singular: 'meter per second'
      plural:   'meters per second'
      aliases: ['m(p|/)?s', 'met(er|re)(s)? per second']
      algos: 
        kmh:  (ms) -> ms * 3.6
        knot: (ms) -> calc_via_kmh 'ms', 'knot', ms
        mph:  (ms) -> calc_via_kmh 'ms', 'mph',  ms
        fps:  (ms) -> calc_via_kmh 'ms', 'fps',  ms

    knot:
      singular: 'knot'
      plural: 'knots'
      aliases: ['k(no)?t(s)?']
      algos: 
        kmh: (knot) -> knot * vars.nautic_mile
        ms:  (knot) -> calc_via_kmh 'knot', 'ms',  knot
        mph: (knot) -> calc_via_kmh 'knot', 'mph', knot
        fps: (knot) -> calc_via_kmh 'knot', 'fps', knot

    mph: 
      singular: 'mile per hour'
      plural: 'miles per hour'
      aliases: ['mph', 'mile(s)? per hour']
      algos: 
        kmh:  (mph) -> mph * vars.mph_magic
        ms:   (mph) -> calc_via_kmh 'mph', 'ms',   mph
        knot: (mph) -> calc_via_kmh 'mph', 'knot', mph
        fps:  (mph) -> calc_via_kmh 'mph', 'fps',  mph

    fps: 
      singular: 'foot per second'
      plural: 'feet per second'
      aliases: ['f(ee|oo)t per second', 'fps', 'ft/s', 'ft/sec']
      algos: 
        kmh:  (fps) -> fps * vars.fps_magic
        ms:   (fps) -> calc_via_kmh 'fps', 'ms',   fps
        knot: (fps) -> calc_via_kmh 'fps', 'knot', fps
        mph:  (fps) -> calc_via_kmh 'fps', 'mph',  fps



