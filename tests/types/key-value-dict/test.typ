#import "/src/lib.typ" as z

#let key-value = (
  "blub": ("abc", true),
)

#z.parse(
  key-value,
  z.key-value-dict(z.string(), z.tuple(z.string(), z.boolean())),
)
