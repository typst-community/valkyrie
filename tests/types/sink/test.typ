#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let positional-schema = z.array()
#let named-schema = z.dictionary((named: z.string()))
#let sink-schema = z.sink(
  positional: positional-schema,
  named: named-schema,
)

#let to-args-type(..args) = args
= types/sink

#{
  let _ = z.parse(to-args-type("hello", named: "0"), sink-schema)
}
// #{let _ = z.parse(to-args-type("hello"), sink-schema)}
#{
  let _ = z.parse(to-args-type(named: "0"), sink-schema)
}
// #{ z.parse(to-args-type(), sink-schema)}