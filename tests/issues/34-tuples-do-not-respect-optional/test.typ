#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.tuple(z.string(), z.string(), z.content(optional: true))

#z.parse(("first", "second"), schema)