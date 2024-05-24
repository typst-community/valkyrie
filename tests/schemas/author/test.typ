#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

= Integration

== Author schema

#[
  #z.parse(
    (
      name: "James R Swift",
      email: "hello@world.com",
    ),
    z.schemas.author,
  )
]
