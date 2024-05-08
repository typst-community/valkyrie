#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  let test-array = ("me@tinger.dev", "hello@world.ac.uk")
  _ = z.parse(test-array, z.array())
  _ = z.parse(test-array, z.array(z.email()))
  _ = z.parse(test-array, z.array(assertions: (z.assert.length.min(1),)))
  _ = z.parse(test-array, z.array(assertions: (z.assert.length.max(3),)))
  _ = z.parse(test-array, z.array(assertions: (z.assert.length.equals(2),)))
  _ = z.parse((), z.array(z.string(), default: (0,)))
}