#import "/src/lib.typ" as z

#let show-rule(body, ..args) = {
  set page(height: auto)
  body
}

#let utility-expect-eq(
  schema: none,
  test: none,
  truth: none,
) = block.with(
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  fill: if (z.parse(test, schema, ctx: z.z-ctx(soft-error: true)) == truth) {
    rgb("#c4e4bd")
  } else {
    rgb("#f5d3d6")
  },
)