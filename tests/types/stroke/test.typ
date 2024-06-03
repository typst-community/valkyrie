#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.stroke()

= types/stroke
== Input types
#let _ = z.parse(stroke(), schema)