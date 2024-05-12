#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();


= Integration

== Pubmatter schema

#[
  #z.parse( 
    (
      title: "Hello World",
      subtitle: [Hello],
      author: (name: "James Swift", affiliation: "lboro"),
      affiliation: "lboro",
      open-access: true,
      license: "CC-BY-NC-SA-4.0"
    ), 
    z.schemas.pubmatter
  )
]