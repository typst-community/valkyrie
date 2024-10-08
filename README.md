# The `Valkyrie` Package
<div align="center">Version 0.2.2</div>

This package implements type validation, and is targeted mainly at package and template developers. The desired outcome is that it becomes easier for the programmer to quickly put a package together without spending a long time on type safety, but also to make the usage of those packages by end-users less painful by generating useful error messages.

## Example Usage
```typ
#import "@preview/valkyrie:0.2.2" as z

#let my-schema = z.dictionary((
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

## Community-lead

As of version 0.2.0, `valkyrie` now resides in the typst-community organisation. Typst users are encouraged to submit additional types, assertions, coercions, and schemas that they believe are already used widely, or should be widely adopted for the health of the ecosystem.