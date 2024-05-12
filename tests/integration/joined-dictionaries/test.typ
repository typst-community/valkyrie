#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

= Integration

#let template-schema = z.dictionary(
  (  
    header: z.dictionary(
      (
        article-type: z.content(default: "Article"),
        article-color: z.color(default: rgb(167,195,212)),
        article-meta: z.content(default: [])
      )
    ),
    fonts: z.dictionary(
      (
        header: z.string(default: "Century Gothic"),
        body: z.string(default: "CMU Sans Serif")
      )
    )
  )
);

#z.parse(
  (
    title:[123456],
    author: "James R Swift"
  ), 
  (z.schemas.pubmatter, template-schema), 
  ctx: z.z-ctx(remove-optional-none: true)
)