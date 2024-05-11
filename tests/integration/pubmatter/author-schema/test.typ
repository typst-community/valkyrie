#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

= Integration

== Author schema


#[
  #z.parse((name:"", affiliation: "1"), z.schemas.author-schema)
]
