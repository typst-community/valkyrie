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
  schema: z.string(min: minimum),
  truth: if (valid) {
    value
  } else {
    none
  },
)([Comparing #value against minimum #minimum])

#test-min(valid: false, "", minimum: 2)
#test-min(valid: false, "a", minimum: 2)
#test-min(valid: true, "ab", minimum: 2)
#test-min(valid: true, "abc", minimum: 2)

=== Min
#let test-min(valid: true, value, maximum: 0) = utility-expect-eq(
  test: value,
  schema: z.string(max: maximum),
  truth: if (valid) {
    value
  } else {
    none
  },
)([Comparing #value against minimum #maximum])

#test-min(valid: true, "", maximum: 1)
#test-min(valid: true, "a", maximum: 1)
#test-min(valid: false, "ab", maximum: 1)
#test-min(valid: false, "abc", maximum: 1)

== Specializations
#z.parse("hello@world.co.uk", z.email())
#z.parse("192.168.0.1", z.ip())

== default
#let _ = z.parse(none, z.string(default: "Hello"))
#let _ = z.parse(auto, z.string(default: "Hello"))
#let _ = z.parse(auto, z.string(default: "Hello", optional: true))
#let _ = repr(z.parse(auto, z.string(optional: true)))
// #z.parse(auto, z.string()) \
#let _ = z.parse("none", z.string(default: "Hello"))