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
      // test: true,
    ),
    z.schemas.author,
    ctx: z.z-ctx(strict: true)
  )
]
