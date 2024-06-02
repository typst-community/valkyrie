#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let positional-schema = z.any()
#let named-schema = z.dictionary((named: z.string()))
#let sink-schema = z.sink(
  positional: positional-schema,
  named: named-schema,
)

#let to-args-type(..args) = args
= types/sink

#z.parse(to-args-type("hello", named: "0"), sink-schema)