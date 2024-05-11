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
    disable: z.dictionary(
      (
        header-journal: z.boolean(default: false),
        footer: z.boolean(default: false)
      )
    ),
    fonts: z.dictionary(
      (
        header: z.string(default: "Century Gothic"),
        body: z.string(default: "CMU Sans Serif")
      )
    )
  )
)

#z.parse((title:[123456]), z.dictionary-join(z.schemas.pubmatter, template-schema))