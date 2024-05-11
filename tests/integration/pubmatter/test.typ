#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();


= Integration

== Pubmatter schema

#[
  #z.parse( (
    open-access: false,
    license: "CC0"
  ), z.schemas.pubmatter)
]
