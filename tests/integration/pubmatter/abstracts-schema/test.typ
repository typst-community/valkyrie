#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.any()

= Integration

== Abstracts schema

#[
  #z.parse([123654], z.schemas.abstracts-schema)
]

