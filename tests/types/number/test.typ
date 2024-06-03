#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.any()

= types/number
== Input types

== Custom assertions

=== Min
#let test-min(valid: true, value, minimum: 0) = utility-expect-eq(
  test: value,
  schema: z.number(min: minimum),
  truth: if (valid) {
    value
  } else {
    none
  },
)([Comparing #value against minimum #minimum])

#test-min(valid: true, 5, minimum: 4)
#test-min(valid: true, 5, minimum: 5)
#test-min(valid: false, 5, minimum: 6)

=== Min
#let test-max(valid: true, value, maximum: 0) = utility-expect-eq(
  test: value,
  schema: z.number(max: maximum),
  truth: if (valid) {
    value
  } else {
    none
  },
)([Comparing #value against maximum #maximum])

#test-max(valid: false, 5, maximum: 4)
#test-max(valid: true, 5, maximum: 5)
#test-max(valid: true, 5, maximum: 6)