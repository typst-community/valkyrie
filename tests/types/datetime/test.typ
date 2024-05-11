#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();
#let schema = z.date()

= types/boolean
== Input types
#{
  let input-types = (
    "date (true)": datetime.today(),
  )

  for (name, value) in input-types{
    utility-expect-eq(test: value, schema: schema, truth: value)([It should validate #name])
  }
}

#{
  let input-types = (
    "none": none,
    "number (0)": 0,
  )

  for (name, value) in input-types{
    utility-expect-eq(test: value, schema: schema, truth: none)([It should fail #name])
  }
}
