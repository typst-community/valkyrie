#import "@preview/tidy:0.1.0"
#import "style.typ"
#import "template.typ": *

#show: project.with(
    title: "Valkyrie",
    subtitle: "Type safe type safety in typst",
    authors: (
        "James R. Swift",
    ),
    url: "https://github.com/JamesxX/valkyrie",
    abstract: [This package implements type validation, and is targetted mainly at package and template developers. The desired outcome is that it becomes easier for the programmer to quickly put a package together without spending a long time on type safety, but also to make the usage of those packages by end-users less painful by generating useful error messages.]
);


// --------------------------------------------
// Setup: Page styling
// --------------------------------------------

// Example code setup
#show raw.where(lang:"typ"): it => block(
  fill: rgb("#F6F4EB"),
  inset: 8pt,
  radius: 5pt,
  width: 100%,
  text(font:"Consolas", it, size: 8.5pt,),
)

// --------------------------------------------
// Title page(s)
// --------------------------------------------
#v(2fr)
= Example usage
```typ
#import "@preview/valkyrie:0.1.0" as z

#let my-schema = z.dictionary(
    should-be-string: z.string(),
    complicated-tuple: z.tuple(
        z.email(),
        z.ip(),
        z.either(
            z.string(),
            z.number()
        )
    )
)

#z.parse(
    (
        should-be-string: "This doesn't error",
        complicated-tuple: (
            "neither@does-this.com",
            "NOT AN IP", // Error: Schema validation failed on argument.complicated-tuple.1: 
                         //        String must be a valid IP address
            1 
        )
    ),
    my-schema
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
As this package introduces several type-like objects, the Tidy style has had these added for clarity. At present, these are #style.show-type("schema") (to represent type-validating objects), #style.show-type("context") (to represent the current state of the parsing heuristic), and #style.show-type("scope") (an array of strings that represents the parent object of values being parsed). #style.show-type("internal") represents arguments that, while settable by the end-user, should be reserved for internal or advanced usage.

Generally, users of this package will only need to be aware of the #style.show-type("schema") type.

=== Specific Language
/ WILL: Indicates a guarantee.
/ MAY: Indicates a possibility without guarantee.
/ MUST: Indicates a requirement. The programmed *MAY* by *ILL-FORMED* if it does not follow the requirement.
/ SHOULD: Indicates a soft requirement, but the program remains correctly-formed if the requirement is not met.
/ UNDEFINED BEHAVIOUR: Behaviour resulting from incorrect API usage. Typically, this behaviour has been forseen by the author, but no effort has been made to handle these edge-cases due to complexity or infrequency.
/ ILL-FORMED: Description of a program using the API in an incorrect way such that it is either outside the scope of the package and/or produces *UNDEFINED BEHAVIOUR*.


#pagebreak()

// --------------------------------------------
// Documentation - Functions
// --------------------------------------------
== Functions

#{

    let first = true;

    let modules = (
        "../src/lib.typ",
        "../src/context.typ",
        "../src/types/any.typ",
        "../src/types/array.typ",
        "../src/types/dictionary.typ",
        "../src/types/logical.typ",
        "../src/types/number.typ",
        "../src/types/string.typ",
        "../src/types/tuple.typ",

    )

    for module in modules {
        if ( not first ) { pagebreak() } else {first = false}
        tidy.show-module(tidy.parse-module(read(module)), style: style, sort-functions: none)
        line( length: 100%, stroke: 0.55pt)
    }
}