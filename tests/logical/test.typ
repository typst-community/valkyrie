#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.either(z.email(), z.ip())

= logical/either
== Input types
#{
  let input-types = (
    "ip (1.1.1.1)": "1.1.1.1",
    "email": "test@hello.wor.ld",
  )

  for (name, value) in input-types {
    utility-expect-eq(
      test: value,
      schema: schema,
      truth: value,
    )([It should validate #name])
  }
}