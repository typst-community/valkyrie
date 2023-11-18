#import "/src/lib.typ" as z
#set page(height: auto, paper: "a6")

= String tests

#z.parse("hello@world.co.uk", z.email())

// #z.parse("not an email", z.email())

#z.parse("192.168.0.1", z.ip())

// #z.parse(123, z.ip())

#z.parse("Hello world", z.transform-uppercase(min: 5))

#z.parse( none, z.string(default: "Hello" ))
// #z.parse( none, z.string())
