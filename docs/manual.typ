#import "@preview/tidy:0.1.0"

#import "style.typ"
#import "template.typ": *

#show: project.with(
  title: "Valkyrie",
  subtitle: "Type safe type safety in typst",
  authors: ("James R. Swift", "tinger <me@tinger.dev>"),
  url: "https://github.com/JamesxX/valkyrie",
  abstract: [This package implements type validation, and is targetted mainly at package and template developers. The desired outcome is that it becomes easier for the programmer to quickly put a package together without spending a long time on type safety, but also to make the usage of those packages by end-users less painful by generating useful error messages.]
)


// --------------------------------------------
// Setup: Page styling
// --------------------------------------------

// Example code setup
#show raw.where(lang:"typ"): it => block(
  fill: rgb("#F6F4EB"),
  inset: 8pt,
  radius: 5pt,
  width: 100%,
  text(it, size: 8.5pt,),
)

// --------------------------------------------
// Title page(s)
// --------------------------------------------
#v(2fr)
= Example usage
```typ
#import "@preview/valkyrie:0.1.2" as z

#let my-schema = z.dictionary(
  should-be-string: z.string(),
  complicated-tuple: z.tuple(
    z.email(),
    z.ip(),
    z.either(
      z.string(),
      z.number(),
    ),
  ),
)

#z.parse(
  (
    should-be-string: "This doesn't error",
    complicated-tuple: (
      "neither@does-this.com",
      // Error: Schema validation failed on argument.complicated-tuple.1:
      //        String must be a valid IP address
      "NOT AN IP",
      1,
    ),
  ),
  my-schema,
)
```
#v(1fr)
#pagebreak()


// --------------------------------------------
// Documentation
// --------------------------------------------
= Documentation
This documentation is generated using the Tidy package, and therefore, while every effort is made to ensure it is representative of the API, there may still be errors due to oversight. If you come across such an error, please make an issue (or pull request) on the GitHub repository.

== Terminology
As this package introduces several type-like objects, the Tidy style has had these added for clarity. At present, these are #style.show-type("schema") (to represent type-validating objects), #style.show-type("ctx") (to represent the current state of the parsing heuristic), and #style.show-type("scope") (an array of strings that represents the parent object of values being parsed). #style.show-type("internal") represents arguments that, while settable by the end-user, should be reserved for internal or advanced usage.

Generally, users of this package will only need to be aware of the #style.show-type("schema") type.

=== Specific Language
/ WILL: Indicates a guarantee.
/ MAY: Indicates a possibility without guarantee.
/ MUST: Indicates a requirement. The programmed *MAY* be *ILL-FORMED* if it does not follow the requirement.
/ SHOULD: Indicates a soft requirement, but the program remains correctly-formed if the requirement is not met.
/ UNDEFINED BEHAVIOUR: Behaviour resulting from incorrect API usage. Typically, this behaviour has been forseen by the author, but no effort has been made to handle these edge-cases due to complexity or infrequency.
/ ILL-FORMED: Description of a program using the API in an incorrect way such that it is either outside the scope of the package and/or produces *UNDEFINED BEHAVIOUR*.


#pagebreak()

#import "@preview/outrageous:0.1.0"
#set outline(indent: n => n * 1em )
#show outline.entry: outrageous.show-entry.with(
  // the typst preset retains the normal Typst appearance
  ..outrageous.presets.outrageous-toc,
  // we only override a few things:
  // level-1 entries are italic, all others keep their font style
  font-style: ("italic", auto),
  // no fill for level-1 entries, a thin gray line for all deeper levels
  fill: (none, line(length: 100%, stroke: gray + .5pt)),
)

#outline(depth: 3)

#pagebreak()

// --------------------------------------------
// Documentation - Functions
// --------------------------------------------
== Functions

#{
  let first = true;

  let modules = (
    "../src/lib.typ",
    "../src/ctx.typ",
  )

  for module in modules {
    if not first { pagebreak() } else { first = false }
    tidy.show-module(
      tidy.parse-module(read(module)),
      style: style,
      sort-functions: none,
    )
    line(length: 100%, stroke: 0.55pt)
  }
}

#pagebreak()
== Types

#{
  let first = true;

  let modules = (
    "../src/types/any.typ",
    "../src/types/array.typ",
    "../src/types/dictionary.typ",
    "../src/types/logical.typ",
    "../src/types/number.typ",
    "../src/types/string.typ",
    "../src/types/tuple.typ",
  )

  for module in modules {
    if not first { pagebreak() } else { first = false }
    tidy.show-module(
      tidy.parse-module(read(module)),
      style: style,
      sort-functions: none,
    )
    line(length: 100%, stroke: 0.55pt)
  }
}

#pagebreak()
= Advanced usage
This section covers topics than the novice-to-intermediate users are unlikely to need to know. If you are looking for information on something you want to achieve, and have not found information somewhere within this guide on how to do so, please submit an issue or pull request on GitHub so that further documentation can be added.

#pagebreak()
== Internal functions
These functions are available under `z.advanced`.
#{
  let first = true;

  let modules = (
    "../src/base-type.typ",
  )

  for module in modules {
    if not first { pagebreak() } else { first = false }
    tidy.show-module(
      tidy.parse-module(read(module)),
      style: style,
      sort-functions: none,
    )
    line( length: 100%, stroke: 0.55pt)
  }
}

#pagebreak()
== Defining a schema generator for a new type
The Typst package ecosystem is large and evergrowing. Eventually, someone, somewhere, will want to validate a type or structure that has never been seen before. If this describes your situation, the following guide may be of use. This section covers different ways complicated types can be defined.

=== Type specialization - Novice
It may be the case that your type is simply a narrowing of an already-defined type. In such cases, it may be easy to add a validator for your code. For example, to create a validator for numbers between 5 and 10, you could so as as follows:

```typ
#let specific-number = z.number.with(min: 5, max: 10)
```

=== Type specialization - Intermediate
If the above method is not sufficient to accurately describe your type, then the custom argument (described above) may be suitable.
```typ
#let specific-number = z.number.with(
  custom: it => 5 < it and it < 10,
  custom-error: "Value was incorrect",
)
```

=== Type specialization - Advanced
If the above doesn't work, but would if you had access to information that would otherwise be hidden inside the schema type-like object, then bootstrapping it may be an avenue to explore.
```typ
#let specific-number(..args) = z.number(..args) + (
  // Configure values manually, perhaps override functions.
  // Check source code of schema generator being bootstrapped.
)
```

=== Type specialization - Wizard
For the most advanced types, creating a schema generator from scratch may be the only way (though this definitely is the last stop, this method should cover all cases). To do so, simply define a function that returns a schema-like dictionary.

```typ
#let tuple(my-args, ...) = {
  // Shorthand for the definitions shown below. If you do not modify a function,
  // you may as well omit it and have it set to its default by base-type()
  z.advanced.base-type() + (
    // Magic number
    valkyrie-type: true,
    // Member sometimes used by other classes when they report a failed validation
    name: "my-type",
    // Helper function, generally called by validate()
    assert-type: (self, it, scope:(), ctx: ctx(), types: ()) => {
      if type(it) not in types {
        (self.fail-validation)(
          self,
          it,
          scope: scope,
          ctx: ctx,
          message: (
            "Expected "
            + joinWithAnd(types, ", ", " or ")
            + ". Got "
            + type(it)
          ),
        )
        return false
      }

      true
    },

    // Do your validation here. Call fail-validation() if validation failed.
    // Generally, return none also.
    validate: (self, it, scope: (), ctx: (:)) => it,

    // Customize the mode of failure here
    fail-validation: (self, it, scope: (), ctx: (:), message: "") => {
      let display = "Schema validation failed on " + scope.join(".")
      if message.len() > 0 { display += ": " + message}
      ctx.outcome = display
      if not ctx.soft-error {
        assert(false, message: display)
      }
    }
  )
}
```
