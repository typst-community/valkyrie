#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

= logical/either
== Input types
#{
  let schema = z.either(z.email(), z.ip())
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

  utility-expect-eq(
    test: "neither",
    schema: schema,
    truth: none
  )([It should not validate `"neither"`])
}

#{
  let schema = z.either(
    strict: true,
    z.dictionary((
      seed: z.integer(),
    )),
    z.dictionary((
      dynamic: z.boolean(),
    )),
  )

  z.parse(
    (dynamic: false),
    schema,
  )
}
