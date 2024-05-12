#import "@local/mantys:0.1.3": *
#import "/src/lib.typ" as z

#let package = toml("/typst.toml").package

#show: mantys.with(
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

#add-type("schema", color: rgb("#bda8ed"))
#add-type("z-ctx", color: rgb("#afeda8"))
// #mantys.add-type("scope", color: rgb("#afeda8"))
#add-type("internal", color: rgb("#ff8c8c"))

#example(side-by-side: true)[```typst
#let template-schema = z.dictionary((
  title: z.content(),
  abstract: z.content(default: []),
  dates: z.array(z.dictionary((
    type: z.content(),
    date: z.string()
  ))),
  paper: z.schemas.papersize(default: "a4"),
  authors: z.array(z.dictionary((
    name: z.string(),
    corresponding: z.boolean(default: false),
    orcid: z.string(optional: true)
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
As this package introduces several type-like objects, the Tidy style has had these added for clarity. At present, these are #dtype("schema") (to represent type-validating objects), #dtype("z-ctx") (to represent the current state of the parsing heuristic), and #dtype("scope") (an array of strings that represents the parent object of values being parsed). #dtype("internal") represents arguments that, while settable by the end-user, should be reserved for internal or advanced usage.

Generally, users of this package will only need to be aware of the #dtype("schema") type.

== Specifig language
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in #link("http://www.ietf.org/rfc/rfc2119.txt", [RFC 2119]).

== Use cases
The interface for a template that a user expects and that the developer has implemented are rearly one and the same. Instead, the user will apply common sense and the developer will put in somewhere between a token- and a whole-hearted- attempt at making their interface intuitive. Contrary to what one might expect, this makes it more difficult for the end user to correctly guess the interface as different developers will disagree on what is and isn't intuitive.

By first providing a low-level set of tools for validating 


#pagebreak()
== Parsing functions

#command("parse", arg[object], arg[schemas], arg(ctx: auto), arg(scope: ("argument",)), ret: ("any","none"))[
	Validates an object against one or more schemas. *WILL* return the given object after validation if successful, or none and *MAY* throw a failed assertion error.

	#argument("object", types:"any")[
    Object to validate against provided schema. Object *SHOULD* statisfy the schema requirements. An error *MAY* be produced if not.
  ]
  #argument("schemas", types:("array","schema"))[
    Schema against which `object` is validated. *MUST* be a valid valkyrie schema type.
  ]
  #argument("ctx", default: auto, types: "z-ctx")[
    ctx passed to schema validator function, containing flags that *MAY* alter behaviour.
  ]
  #argument("scope", default: ("argument",), types: "scope")[
    An array of strings used to generate the string representing the location of a failed requirement within `object`. *MUST* be an array of strings of length greater than or equal to `1`
  ]

]


#pagebreak()
== Schema definition functions
For the sake of brevity and owing to their consistency, the arguments that each schema generating function accepts are listed in the table below, followed by a description of each of argument.

#let rotatex(body,angle) = style(styles => {
  let size = measure(body,styles)
  box(inset:(x: -size.width/2+(size.width*calc.abs(calc.cos(angle))+size.height*calc.abs(calc.sin(angle)))/2,
             y: -size.height/2+(size.height*calc.abs(calc.cos(angle))+size.width*calc.abs(calc.sin(angle)))/2),
             rotate(body,angle))
})

#align( center, table(
  stroke: black + 0.75pt,
  columns: (1fr,) + 12*(auto,),
  inset: 9pt,
  align: (horizon, horizon+center),
  table.header(
    [], 
    rotatex([*any*], -90deg),
    rotatex([*array*], -90deg),
    rotatex([*boolean*], -90deg),
    rotatex([*color*], -90deg),
    rotatex([*content*], -90deg),
    rotatex([*date*], -90deg),
    rotatex([*dictionary*], -90deg),
    rotatex([*either*], -90deg),
    rotatex([*number, integer, float*], -90deg),
    rotatex([*string, ip, email*], -90deg),
    rotatex([*tuple*], -90deg),
    rotatex([*choice*], -90deg),
  ),
  [body],           [ ],[✔],[ ],[ ],[ ],[ ],[✔],[✔],[ ],[ ],[✔],[✔],
  [name],           [✱],[✱],[✱],[✱],[✱],[✱],[✱], [✱],[✱],[✱],[✱],[✱],
  [optional],       [✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],
  [default],        [✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],
  [types],          [✔],[✱],[✱],[✱],[✱],[✱],[✱],[✱],[✱],[✱],[✱],[],
  [assertions],     [✔],[✔],[✔],[✔],[✔],[✔],[✱],[ ],[✔],[✱],[✔],[✱],
  [pre-transform],  [✔],[ ],[ ],[ ],[ ],[ ],[✱],[ ],[ ],[ ],[✔],[ ],
  [post-transform], [✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],[✔],
))

✔ Indicates that the argument is available to the user.
✱ Indicates that while the argument is availble to the user, it may be used internally or may hold a default value.

#pagebreak()

#block(breakable: false,
argument("name", default: "unknown", types: "string")[Human-friendly name of the schema for error-reporting purposes.])
  
#block(breakable: false,
argument("optional", default: false, types: "boolean")[
  Allows the value to have not been set at the time of parsing, without generating an error.
  #mty.alert[If used on a dictionary, consider adding default values to child schemas instead.]
  #mty.alert[If used on a array, consider relying on the default (an empty array) instead.]
])

#block(breakable: false,
argument("default", default: none, types: "any")[
  The default value to use if object being validated is `none`.
  #mty.alert[Setting a default value allows the end-user to omit it.]
])

#block(breakable: false,
argument("types", default: (), types: "array")[Array of allowable types. If not set, all types are accepted])

#block(breakable: false,
argument("assertions", default: (), types: "array")[
  Array of assertions to be tested during object validation. see (LINK TO ASSERTIONS)

  #mty.alert[Assertions cannot modify values]
])

#block(breakable: false,
argument("pre-transform", default: "(self,it)=>it", types: "function")[
  Transformation to apply prior to validation. Can be used to coerce values.
  
])

#block(breakable: false,
argument("post-transform", default: "(self,it)=>it", types: "function")[Transformation to apply after validation. Can be used to reshape values for internal use

])

#pagebreak()
#command("any", arg[object], arg[schemas], arg(ctx: auto), arg(scope: ("argument",)), ret: "schema")[]
#command("array", arg[object], arg[schemas], arg(ctx: auto), arg(scope: ("argument",)), ret: ("any","none"))[]
#pagebreak()
== Special Generator functions
=== Array
=== Dictionary
=== Either
=== Tuple

== Coercions

== Assertions

#pagebreak()
= Advanced Documentation
== Validation heuristic

#import "@preview/fletcher:0.4.4" as fletcher: diagram, node, edge, shapes

#figure(
  align(center, diagram(
    spacing: 2em,
    node-stroke: 0.75pt,
    edge-stroke: 0.75pt,
    node((-2,1), [Start], corner-radius: 2pt, shape: shapes.circle),
    edge("-|>"),
    node((0,1), align(center)[`value` or `self.default`]),
    edge("-|>"),
    node((0,2), align(center)[pre-transform value], corner-radius: 2pt),
    edge("-|>"),
    node((0,3), align(center)[Assert type of value], corner-radius: 2pt),

    node((-1,4), align(center)[Allow #repr(none) if \ `self.optional` is #true], corner-radius: 2pt),
    node((0,4), align(center)[Allow if `self.types` \ length is 0], corner-radius: 2pt),
    node((1,4), align(center)[Allow `value` if type in \ `self.types` is #true], corner-radius: 2pt),

    node((1,3), align(center)[`self.fail-validation`], corner-radius: 2pt),
    edge("-|>"),
    node((2,3), align(center)[throw], corner-radius: 2pt, shape: shapes.circle),

    edge((0,3), (-1,4), "-|>", bend: -20deg) , edge( (-1,4), (0,5), "-|>", bend: -20deg),
    edge((0,3), (0,4), "-|>"), edge( (0,4), (0,5), "-|>"),
    edge((0,3), (1,4), "-|>", bend: 20deg), edge( (1,4), (0,5), "-|>", bend: 20deg),
    edge((0,3), (1,3), "-|>"),

    node((0,5), align(center)[Handle descendents \ transformation], corner-radius: 2pt),
    edge("ll,uuuu", "|>--|>", align(center)[child schema \ on descendent], label-side: left, label-pos: 0.3),
    edge("-|>"),
    node((0,6), align(center)[Handle assertions \ transformation], corner-radius: 2pt),
    edge("-|>"),
    node((1,6), align(center)[post-transform `value`], corner-radius: 2pt),
    edge("-|>"),
    node((2,6), [end], corner-radius: 2pt, shape: shapes.circle),
  ) + v(2em)),
  caption: [Flow diagram representation of parsing heuristic when validating a value against a schema.]
)


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
