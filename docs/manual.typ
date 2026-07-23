#import "template/dependencies.typ": *
#import "template/documentation.typ" as template
#import "template/style.typ"

#show:  template.rule.with()

= Preface

== Terminology
As this package introduces several type-like objects, the Tidy style has had these added for clarity. At present, these are #style.show-type("schema") (to represent type-validating objects), #style.show-type("z-ctx") (to represent the current state of the parsing heuristic), and #style.show-type("scope") (an array of strings that represents the parent object of values being parsed). #style.show-type("internal") represents arguments that, while settable by the end-user, should be reserved for internal or advanced usage.

In general, users of this package will only need to be aware of the #style.show-type("schema") type (see @z.schema)

== Specific language

#let specific(body) = text(weight: "black", upper(body))
#let specific-texts = ("must", "must not", "required", "shall", "shall-not", "should", "should not", "recommended", "may", "optional")
#let specifics = specific-texts.fold((:), (acc, var) => acc + ( (var.replace("-", " ")) : specific(var) ))

The key words #specifics.values().join(", ", last: ", and ") in this document are to be interpreted as described in #link("http://www.ietf.org/rfc/rfc2119.txt", [RFC 2119]).

== Use cases
The interface for a template that a user expects and that the developer has implemented are rearly one and the same. Instead, the user will apply common sense and the developer will put in somewhere between a token- and a whole-hearted- attempt at making their interface intuitive. Contrary to what one might expect, this makes it more difficult for the end user to correctly guess the interface as different developers will disagree on what is and isn't intuitive, and what edge cases the developer is willing to cover.

By first providing a low-level set of tools for validating primitives upon which more complicated schemas can be defined, `Valkyrie` handles both the micro and macro of input validation.

= Examples

= Data structures

== Schema <z.schema>

= API Reference
#set par(justify: false)

#let parse-module = tidy.parse-module.with(
  scope: (
    z: z,
    specifics: specifics
  ),
  label-prefix: "z"
)

#let show-module = tidy.show-module.with(
  first-heading-level: 1,
  style: style,
  show-outline: false,
)


#let docs-module            = parse-module(read("/src/lib.typ"))

#let docs-types             = parse-module(read("/src/types.typ"))
#let docs-types-base        = parse-module(read("/src/base-type.typ"))
#let docs-types-array       = parse-module(read("/src/types/array.typ"))
#let docs-types-dictionary  = parse-module(read("/src/types/dictionary.typ"))
#let docs-types-logical     = parse-module(read("/src/types/logical.typ"))
#let docs-types-number      = parse-module(read("/src/types/number.typ"))
#let docs-types-sink        = parse-module(read("/src/types/sink.typ"))
#let docs-types-string      = parse-module(read("/src/types/string.typ"))
#let docs-types-tuple       = parse-module(read("/src/types/tuple.typ"))

#let docs-schemas           = parse-module(read("/src/schemas.typ"))
#let docs-schemas-author    = parse-module(read("/src/schemas/author.typ"))
#let docs-schemas-enums     = parse-module(read("/src/schemas/enumerations.typ"))

#let docs-assertions        = parse-module(read("/src/assertions.typ"), label-prefix: "z.assertions")
#let docs-assertions-strings = parse-module(read("/src/assertions/string.typ"), label-prefix: "z.assertions")
#let docs-assertions-length = parse-module(read("/src/assertions/length.typ"), label-prefix: "z.assertions.length",)

#let docs-coercions         = parse-module(read("/src/coercions.typ"), label-prefix: "z.coercions")

#let docs-adv-assert-utils  = parse-module(read("/src/assertions-util.typ"))
#let docs-ctx               = parse-module(read("/src/ctx.typ"))

#let merge-modules(first, ..args) = {
  let ret = first
  for arg in args.pos() {
    ret.functions += arg.functions
    ret.variables += arg.variables
  }


  return ret
}

#show-module(
  merge-modules(
    docs-module,
    docs-types,
    docs-types-array,
    docs-types-dictionary,
    docs-types-logical,
    docs-types-number,
    docs-types-sink,
    docs-types-string,
    docs-types-tuple,
  ),
  sort-functions: auto
)

= API Reference (Predefined schemas)
#show-module(merge-modules(
  docs-schemas,
  docs-schemas-author,
  docs-schemas-enums
))

= API Reference (Assertions)
#show-module(merge-modules(
  docs-assertions,
  docs-assertions-strings
))
== length
#show-module(merge-modules(
  docs-assertions-length
),
first-heading-level: 2)

= API Reference (Coercions)
#show-module(merge-modules(docs-coercions))

= API Reference (Advanced)

#show-module(merge-modules(
  docs-types-base,
  docs-ctx,
  docs-adv-assert-utils
))
