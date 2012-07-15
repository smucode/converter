define [], () ->
  ms:
    singular: 'meter per second'
    plural:   'meters per second'
    aliases: ['m(p|/)?s', 'met(er|re)(s)? per second']
    algos: 
      kmh: (val) -> val * 3.6
  kmh:
    singular: 'kilometer per hour'
    plural:   'kilometers per hour'
    aliases: ['k(m|p|mp)h', 'kilomet(er|re)(s)? per hour']
    algos: 
      ms: (val) -> val / 3.6