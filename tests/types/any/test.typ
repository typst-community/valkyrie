#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.any()

= types/any
== Input types
#{
  let input-types = (
    "content (empty)": [],
    "content (lorem)": lorem(20),
    "number (0)": 0,
    "number (negative float)": -1.2,
    "string (empty)": "",
    "string (lorem)": str(lorem(20)),
    "dictionary (empty)": (:),
    "dictionary": (foo:"bar"),
  )

  for (name, value) in input-types{
    utility-expect-eq(test: value, schema: schema, truth: value)([It should validate #name])
  }
}

#z.parse(none, z.any(optional: true))