define ['underscore'], (_) -> 
  vars = 
    nautic_mile: 1.852
    mph_magic: 1.609344
    fps_magic: 1.09728

  calc_via_kmh = (from, to, val) ->
    kmh = defs[from].algos.kmh val
    defs.kmh.algos[to] kmh

  units = ['fps', 'kmh', 'ms', 'knot', 'mph']

  defs = 
    kmh:
      singular: 'kilometer per hour'
      plural:   'kilometers per hour'
      aliases: ['k(m|p|mp|m/)h', 'kilomet(er|re)(s)? per hour']
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

    knot:
      plural: 'knots'
      singular: 'knot'
      aliases: ['k(no)?t(s)?']
      algos: 
        kmh: (knot) -> knot * vars.nautic_mile

    mph: 
      plural: 'miles per hour'
      singular: 'mile per hour'
      aliases: ['mph', 'mile(s)? per hour']
      algos: 
        kmh:  (mph) -> mph * vars.mph_magic

    fps: 
      plural: 'feet per second'
      singular: 'foot per second'
      aliases: ['f(ee|oo)t per second', 'fps', 'ft/s', 'ft/sec']
      algos: 
        kmh:  (fps) -> fps * vars.fps_magic

  # create default algo fns via kmh
  _.each defs, (o, unit) ->
    _.each _.keys(defs), (algo_unit) ->
      if !o.algos[algo_unit] and unit != algo_unit
        o.algos[algo_unit] = (val) ->
          calc_via_kmh unit, algo_unit, val

  # create reflective algos
  _.each defs, (o, unit) ->
    o.algos[unit] = (val) -> val
  
  defs  



