#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.any()

= Integration

== Author schema

#let author-schema = z.dictionary((
  name: z.string(),
  url: z.optional(z.string()),
  phone: z.optional(z.string()),
  fax: z.optional(z.string()),
  orcid: z.optional(z.string()),
  note: z.optional(z.string()),
  corresponding: z.optional(z.boolean()),
  equal-contributor: z.optional(z.boolean()),
  deceased: z.optional(z.boolean()),
  roles: z.array(z.string()),
  // Affiliations
))

#z.parse("123", z.optional(z.string()))

#z.parse(
  (
    name: "hello",
    phone: 123,
    corresponding: true,
    note: "hello world",
  ),
  author-schema
)

== Pubmatter schema

#let pubmatter-schema = z.dictionary((
  title: z.optional(z.content()),
  subtitle: z.optional(z.content()),
  shot-title: z.optional(z.string()),
))
