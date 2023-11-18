#import "/src/lib.typ" as z
#set page(height: auto, paper: "a6")

= Locial tests

#z.parse( "1.1.1.1", z.either(z.email(), z.ip()))

#z.parse( "test@hello.wor.ld", z.either(z.email(), z.ip()))

//#z.parse( "neither email or ip", z.either(z.email(), z.ip()))
