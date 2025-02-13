#import "/src/lib.typ" as z

#let soft-parse = z.parse.with(ctx: z.z-ctx(soft-error: true))

= Assertions/Comparative
== z.assert.min

#let min-number-schema(val) = z.number(assertions: (z.assert.min(val),))

#assert(soft-parse(5, min-number-schema(4)) == 5)
#assert(soft-parse(5, min-number-schema(5)) == 5)
#assert(soft-parse(5, min-number-schema(6)) == none)

== z.assert.max

#let max-number-schema(val) = z.number(assertions: (z.assert.max(val),))

#assert(soft-parse(5, max-number-schema(4)) == none)
#assert(soft-parse(5, max-number-schema(5)) == 5)
#assert(soft-parse(5, max-number-schema(6)) == 5)

== z.assert.eq

#let eq-number-schema(val) = z.number(assertions: (z.assert.eq(val),))

#assert(soft-parse(5, eq-number-schema(4)) == none)
#assert(soft-parse(5, eq-number-schema(5)) == 5)
#assert(soft-parse(5, eq-number-schema(6)) == none)
