#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();


= Integration

== Pubmatter schema

#[
  #z.parse( (
  title: "",
  author: (
    (
      name:"James R Swift",
      affiliations: (1),
    ),
    "DSF"
  ),
  affiliation: (institution: "name"),
  open-access: false,
  abstract: []

  ), z.schemas.pubmatter )
]
