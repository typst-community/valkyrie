#import "dependencies.typ": *
#import "template/documentation.typ" as template
#import "template/style.typ"

#show:  template.rule.with()

= Preface

== Use cases
The interface for a template that a user expects and that the developer has implemented are rearly one and the same. Instead, the user will apply common sense and the developer will put in somewhere between a token- and a whole-hearted- attempt at making their interface intuitive. Contrary to what one might expect, this makes it more difficult for the end user to correctly guess the interface as different developers will disagree on what is and isn't intuitive, and what edge cases the developer is willing to cover.

By first providing a low-level set of tools for validating primitives upon which more complicated schemas can be defined, `Valkyrie` handles both the micro and macro of input validation.


= Reading this manual

== Terminology
As this package introduces several type-like objects, this manual will denote these in a similar fashion as natively defined types. At present, these are:
/ #style.show-type("schema") : to represent type-validation descriptions. Several are provided out-of-the-box both as individual units for discrete types which can be further composed, aswell as schemes defined within the library to serve a general community need. 
/ #style.show-type("z-ctx") : to represent the current state of the parsing heuristic. Modifying the values held in this type can significantly alter how certain aspects of the validation pipeline take place. There are very few cases where a template developer or consumer will need have any knowledge about it.
/ #style.show-type("scope") : to represent an array of strings that keep track of the namespace within which a nested field is being validated. It's primary use is in error message generation. 

Separately, some functions or arguments will be marked as #style.show-type("internal"), indicating that while these are available the end-user, they should be reserved for internal or advanced usage. The underlying implementation should not be relied upon and may be subject to change.

In general, users of this package will only need to be aware of the #style.show-type("schema") type (see @z.schema)

== Specific language

#let specific(body) = text(weight: "black", upper(body))
#let specific-texts = ("must", "must not", "required", "shall", "shall-not", "should", "should not", "recommended", "may", "optional")
#let specifics = specific-texts.fold((:), (acc, var) => acc + ( (var.replace("-", " ")) : specific(var) ))

The key words #specifics.values().join(", ", last: ", and ") in this document are to be interpreted as described in #link("http://www.ietf.org/rfc/rfc2119.txt", [RFC 2119]).


= Examples

= Data structures

== Schema <z.schema>

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

// TODO: describe module namespaces w.r.t. source impl files and automate docs

#let document-namespace(

) = {

  
}

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

#let docs-schemas           = parse-module(read("/src/schemas.typ"), label-prefix: "z.schemes")
#let docs-schemas-author    = parse-module(read("/src/schemas/author.typ"), label-prefix: "z.schemes")
#let docs-schemas-enums     = parse-module(read("/src/schemas/enumerations.typ"), label-prefix: "z.schemes")

#let docs-assertions        = parse-module(read("/src/assertions.typ"), label-prefix: "z.assert")
#let docs-assertions-strings = parse-module(read("/src/assertions/string.typ"), label-prefix: "z.assert")
#let docs-assertions-comp   = parse-module(read("/src/assertions/comparative.typ"), label-prefix: "z.assert")
#let docs-assertions-length = parse-module(read("/src/assertions/length.typ"), label-prefix: "z.assert.length",)

#let docs-coercions         = parse-module(read("/src/coercions.typ"), label-prefix: "z.coerce")

#let docs-adv-assert-utils  = parse-module(read("/src/assertions-util.typ"), label-prefix: "z.advanced")
#let docs-ctx               = parse-module(read("/src/ctx.typ"))

#let merge-modules(first, ..args) = {
  let ret = first
  for arg in args.pos() {
    ret.functions += arg.functions
    ret.variables += arg.variables
  }


  return ret
}

= API Reference
#show-module(
  merge-modules(
    docs-module,
    docs-types-base,
  ),
  sort-functions: false
)



= API Reference (Schema Definition)

#show-module(
  merge-modules(
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
  docs-assertions-strings,
  docs-assertions-comp
))
== length
#show-module(merge-modules(
  docs-assertions-length
),
first-heading-level: 2)

= API Reference (Coercions)
#show-module(merge-modules(docs-coercions))

= API Reference (Advanced)

#show-module(docs-ctx)
#show-module(docs-adv-assert-utils)
