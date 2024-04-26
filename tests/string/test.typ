#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  _ = z.parse("hello@world.co.uk", z.email())
  _ = z.parse("192.168.0.1", z.ip())
  _ = z.parse("Hello world", z.transform-uppercase(min: 5))
  _ = z.parse( none, z.string(default: "Hello" ))
}
