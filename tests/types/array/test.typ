#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.array()

= types/array
== Input types
#{
  let input-types = (
    "array (empty)": (),
    "array (single)": (0,),
  )

  for (name, value) in input-types{
    utility-expect-eq(test: value, schema: schema, truth: value)([It should validate #name])
  }
}

== Test \#1
#let test-array = ("me@tinger.dev", "hello@world.ac.uk")
#test-array

#utility-expect-eq(
  test: test-array, 
  schema: z.array(), 
  truth: test-array
)([Test satisfies array\<any\>])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email()), 
  truth: test-array
)([Test satisfies array\<email\>])

=== Assertions

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.min(1),)), 
  truth: test-array
)([Test satisfies array\<email\> min length 1])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.min(2),)), 
  truth: test-array
)([Test satisfies array\<email\> min length 2])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.min(3),)), 
  truth: ()
)([Test fails array\<email\> min length 3])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.max(1),)), 
  truth: ()
)([Test fails array\<email\> max length 1])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.max(2),)), 
  truth: test-array
)([Test satisfies array\<email\> max length 2])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.max(3),)), 
  truth: test-array,
)([Test satisfies array\<email\> max length 3])

==== Length

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.equals(2),)), 
  truth: test-array
)([Test satisfies array\<email\> equal length 2])

#utility-expect-eq(
  test: test-array, 
  schema: z.array(z.email(), assertions: (z.assert.length.equals(3),)), 
  truth: ()
)([Test fails array\<email\> equal length 3])



#{
  let test-array = ("me@tinger.dev", "hello@world.ac.uk")
  _ = z.parse(test-array, z.array())
  _ = z.parse(test-array, z.array(z.email()))
  _ = z.parse(test-array, z.array(z.email(), assertions: (z.assert.length.min(1),)))
  _ = z.parse(test-array, z.array(z.email(), assertions: (z.assert.length.max(3),)))
  _ = z.parse(test-array, z.array(assertions: (z.assert.length.equals(2),)))
  _ = z.parse((), z.array(z.string(), default: (0,)))
}