#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let soft-parse = z.parse.with(ctx: z.z-ctx(soft-error: true))

= Assertions/Comparative
== z.assert.min

#let min-number-schema(val) = z.number(assertions: (z.assert.min(val),))

#{soft-parse(5, min-number-schema(4) ) == 5 }\
#{soft-parse(5, min-number-schema(5) ) == 5 }\
#{soft-parse(5, min-number-schema(6) ) == none }

== z.assert.max

#let max-number-schema(val) = z.number(assertions: (z.assert.max(val),))

#{soft-parse(5, max-number-schema(4) ) == none }\
#{soft-parse(5, max-number-schema(5) ) == 5 }\
#{soft-parse(5, max-number-schema(6) ) == 5 }

== z.assert.eq

#let eq-number-schema(val) = z.number(assertions: (z.assert.eq(val),))

#{soft-parse(5, eq-number-schema(4) ) == none }\
#{soft-parse(5, eq-number-schema(5) ) == 5 }\
#{soft-parse(5, eq-number-schema(6) ) == none }