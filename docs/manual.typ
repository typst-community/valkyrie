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
// #mantys.add-type("scope", color: rgb("#afeda8"))
#mantys.add-type("internal", color: rgb("#ff8c8c"))

#mantys.example(side-by-side: true)[```typst
#let template-schema = z.dictionary(
  title: z.content(),
  abstract: z.content(default: []),
  dates: z.array(z.dictionary(
    type: z.content(),
    date: z.string()
  )),
  paper: z.papersize(default: "a4"),
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
  (
    title: [],
    disable: (footer: true),
    authors: ( (name: "Example"),)
  ),
  template-schema,
)

```]

= Documentation
== Terminology
As this package introduces several type-like objects, the Tidy style has had these added for clarity. At present, these are #mantys.dtype("schema") (to represent type-validating objects), #mantys.dtype("z-ctx") (to represent the current state of the parsing heuristic), and #mantys.dtype("scope") (an array of strings that represents the parent object of values being parsed). #mantys.dtype("internal") represents arguments that, while settable by the end-user, should be reserved for internal or advanced usage.

Generally, users of this package will only need to be aware of the #mantys.dtype("schema") type.

== Specifig language
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in #link("http://www.ietf.org/rfc/rfc2119.txt", [RFC 2119]).

#pagebreak()
== Parsing functions

#mantys.tidy-module(read("/src/lib.typ"), name: "chemicoms-paper")
#mantys.tidy-module(read("/src/ctx.typ"), name: "chemicoms-paper")

#pagebreak()
== Schema definition functions

=== Any
#mantys.tidy-module(read("/src/types/any.typ"), name: "chemicoms-paper") #pagebreak()

=== Array
#mantys.tidy-module(read("/src/types/array.typ"), name: "chemicoms-paper") #pagebreak()

=== Boolean
#mantys.tidy-module(read("/src/types/boolean.typ"), name: "chemicoms-paper") #pagebreak()

=== Choice
#mantys.tidy-module(read("/src/types/choice.typ"), name: "chemicoms-paper") #pagebreak()

=== Color
#mantys.tidy-module(read("/src/types/color.typ"), name: "chemicoms-paper") #pagebreak()

=== Content
#mantys.tidy-module(read("/src/types/content.typ"), name: "chemicoms-paper") #pagebreak()

=== Dictionary
#mantys.tidy-module(read("/src/types/dictionary.typ"), name: "chemicoms-paper") #pagebreak()

=== Logical 
#mantys.tidy-module(read("/src/types/logical.typ"), name: "chemicoms-paper") #pagebreak()

=== Number
#mantys.tidy-module(read("/src/types/number.typ"), name: "chemicoms-paper") #pagebreak()

=== String
#mantys.tidy-module(read("/src/types/string.typ"), name: "chemicoms-paper") #pagebreak()

=== Tuple
#mantys.tidy-module(read("/src/types/tuple.typ"), name: "chemicoms-paper")