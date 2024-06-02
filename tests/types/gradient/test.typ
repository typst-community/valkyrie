#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.gradient()

= types/gradient
== Input types
#z.parse(gradient.linear(..color.map.rainbow), schema)