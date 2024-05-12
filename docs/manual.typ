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
#let template-schema = z.dictionary((
  title: z.content(),
  abstract: z.content(default: []),
  dates: z.array(z.dictionary((
    type: z.content(),
    date: z.string()
  ))),
  paper: z.papersize(default: "a4"),
  authors: z.array(z.dictionary((
    name: z.string(),
    corresponding: z.boolean(default: false),
    orcid: z.optional(z.string())
  ))),
  header: z.dictionary((
    journal: z.content(default: [Journal Name]),
    article-type: z.content(default: "Article"),
    article-color: z.color(default: rgb(167,195,212)),
    article-meta: z.content(default: [])
  )),
));


#z.parse(
  (
    title: [This is a required title],
    paper: "a3",
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
#mantys.tidy-module(read("/src/types/tuple.typ"), name: "chemicoms-paper")#pagebreak()

// = Advanced Documentation

// == Internal functions
// The following functions are made available to users under the `z.advanced` namespace.
// #mantys.tidy-module(read("/src/base-type.typ"), name: "chemicoms-paper")#pagebreak()

// The Typst package ecosystem is large and evergrowing. Eventually, someone, somewhere, will want to validate a type or structure that has never been seen before. If this describes your situation, the following guide may be of use. This section covers different ways complicated types can be defined.

// == Type specialization

// === Novice
// It may be the case that your type is simply a narrowing of an already-defined type. In such cases, it may be easy to add a validator for your code. For example, to create a validator for numbers between 5 and 10, you could so as as follows:

// ```typ
// #let specific-number = z.number.with(min: 5, max: 10)
// ```

// === Intermediate
// If the above method is not sufficient to accurately describe your type, then the custom argument (described above) may be suitable.
// ```typ
// #let specific-number = z.number.with(
//   custom: it => 5 < it and it < 10,
//   custom-error: "Value was incorrect",
// )
// ```

// === Advanced
// If the above doesn't work, but would if you had access to information that would otherwise be hidden inside the schema type-like object, then bootstrapping it may be an avenue to explore.
// ```typ
// #let specific-number(..args) = z.number(..args) + (
//   // Configure values manually, perhaps override functions.
//   // Check source code of schema generator being bootstrapped.
// )
// ```

// === Wizard
// For the most advanced types, creating a schema generator from scratch may be the only way (though this definitely is the last stop, this method should cover all cases). To do so, simply define a function that returns a schema-like dictionary.

// ```typ
// #let tuple(my-args, ...) = {
//   // Shorthand for the definitions shown below. If you do not modify a function,
//   // you may as well omit it and have it set to its default by base-type()
//   z.advanced.base-type() + (
//     // Magic number
//     valkyrie-type: true,
//     // Member sometimes used by other classes when they report a failed validation
//     name: "my-type",
//     // Helper function, generally called by validate()
//     assert-type: (self, it, scope:(), ctx: ctx(), types: ()) => {
//       if type(it) not in types {
//         (self.fail-validation)(
//           self,
//           it,
//           scope: scope,
//           ctx: ctx,
//           message: (
//             "Expected "
//             + joinWithAnd(types, ", ", " or ")
//             + ". Got "
//             + type(it)
//           ),
//         )
//         return false
//       }

//       true
//     },

//     // Do your validation here. Call fail-validation() if validation failed.
//     // Generally, return none also.
//     validate: (self, it, scope: (), ctx: (:)) => it,

//     // Customize the mode of failure here
//     fail-validation: (self, it, scope: (), ctx: (:), message: "") => {
//       let display = "Schema validation failed on " + scope.join(".")
//       if message.len() > 0 { display += ": " + message}
//       ctx.outcome = display
//       if not ctx.soft-error {
//         assert(false, message: display)
//       }
//     }
//   )
// }
// ```
