#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();


= Integration

== Pubmatter schema

#[
  #z.parse( 
    (
      title: "Hello World",
      author: "James Swift",
      open-access: false,
      //license: "CC-BY"
    ), 
    z.schemas.pubmatter
  )
]