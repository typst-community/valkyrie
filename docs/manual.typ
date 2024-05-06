#import "@local/mantys:0.1.3" as mantys
#import "/src/lib.typ" as z

#let package = toml("/typst.toml").package

#show: mantys.mantys.with(
  ..package,
  title: [Valkyrie],
  date: datetime.today().display(),
  abstract: [This package implements type validation, and is targetted mainly at package and template developers. The desired outcome is that it becomes easier for the programmer to quickly put a package together without spending a long time on type safety, but also to make the usage of those packages by end-users less painful by generating useful error messages.],
  examples-scope: (z: z),
)

#show raw: it => {
  show "{{VERSION}}": package.version
  it
}

= Example usage

#mantys.add-type("schema", color: rgb("#bda8ed"))
#mantys.add-type("z-ctx", color: rgb("#afeda8"))

#mantys.example(side-by-side: true)[```typst
#let template-schema = z.dictionary(
  title: z.content(),
  abstract: z.content(default: []),
  dates: z.array(z.dictionary(
    type: z.content(),
    date: z.string()
  )),
  //paper: z.papersize(default: "a4"),
  authors: z.array(z.dictionary(
    name: z.string(),
    corresponding: z.boolean(default: false),
    orcid: z.optional(z.string())
  )),
  header: z.dictionary(
    journal: z.content(default: [Journal Name]),
    article-type: z.content(default: "Article"),
    article-color: z.color(default: rgb(167,195,212)),
    article-meta: z.content(default: [])
  ),
  keywords: z.array(z.string()),
  doi: z.optional(z.string()),
  citation: z.content(default: []),
  disable: z.dictionary(
    header-journal: z.boolean(default: false),
    footer: z.boolean(default: false)
  ),
  fonts: z.dictionary(
    header: z.string(default: "Century Gothic"),
    body: z.string(default: "CMU Sans Serif")
  )
);


#z.parse(
  (title: [],disable: (footer: true),),
  template-schema,
)

```]

= Documentation
== Terminology
== Specifig language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in #link("http://www.ietf.org/rfc/rfc2119.txt", [RFC 2119]).


== Parsing functions

#mantys.tidy-module(read("/src/lib.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/ctx.typ"), name: "chemicoms-paper")

== Schema definition functions


#mantys.tidy-module(read("/src/types/any.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/array.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/boolean.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/choice.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/color.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/content.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/dictionary.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/logical.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/number.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/string.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/types/tuple.typ"), name: "chemicoms-paper")