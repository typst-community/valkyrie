#import "/src/lib.typ" as z
#set page(height: auto, paper: "a6")

= Dictionary tests

#let test-dictionary = (
  string: "world",
  number: 1.2,
  email: "hello@world.com",
  ip: "1.1.251.1",
  should-be-ip: "but isn't"
)

#z.parse(test-dictionary, z.dictionary(
  string: z.string(min: 4),
  // TO DO: number
  email: z.email(),
  ip: z.ip(),
  should-be-ip: z.ip()
))