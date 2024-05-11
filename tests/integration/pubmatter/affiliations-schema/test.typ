#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

= Integration

== Affiliation schema


#[
  #z.parse((institution: "sdf"), z.schemas.affiliation-schema)
]
