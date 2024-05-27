#import "/src/lib.typ" as z

#let test-dictionary = (
  string: "world",
  number: 1.2,
  email: "hello@world.com",
  ip: "1.1.251.1",
)

#z.parse(
  test-dictionary,
  z.dictionary((
    string: z.string(assertions: (z.assert.length.min(5),), optional: true),
    number: z.number(optional: true),
    email: z.email(optional: true),
    ip: z.ip(optional: true),
  )),
)
