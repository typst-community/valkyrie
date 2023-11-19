#import "/src/lib.typ" as z
#set page(height: auto, paper: "a6")

= Tuple Tests

#let test-tuple = ("String", "email@address.co.uk", 1.1)

#z.parse(test-tuple, z.tuple(
  z.string(),
  z.email(),
  z.floating-point()
))