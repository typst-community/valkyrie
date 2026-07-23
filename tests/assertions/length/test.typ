#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let soft-parse = z.parse.with(ctx: z.z-ctx(soft-error: true))

= Assertions/Length
== z.assert.length.min

#let min-string-schema(val) = z.string(assertions: (z.assert.length.min(val),))

#{
  soft-parse("hello", min-string-schema(4)) == "hello"
}\
#{
  soft-parse("hello", min-string-schema(5)) == "hello"
}\
#{
  soft-parse("hello", min-string-schema(6)) == none
}

== z.assert.length.max

#let max-string-schema(val) = z.string(assertions: (z.assert.length.max(val),))

#{
  soft-parse("hello", max-string-schema(4)) == none
}\
#{
  soft-parse("hello", max-string-schema(5)) == "hello"
}\
#{
  soft-parse("hello", max-string-schema(6)) == "hello"
}

== z.assert.length.equals

#let equals-string-schema(val) = z.string(assertions: (z.assert.length.equals(val),))

#{
  soft-parse("hello", equals-string-schema(4)) == none
}\
#{
  soft-parse("hello", equals-string-schema(5)) == "hello"
}\
#{
  soft-parse("hello", equals-string-schema(6)) == none
}

== z.assert.length.neq

#let neq-string-schema(val) = z.string(assertions: (z.assert.length.neq(val),))

#{
  soft-parse("hello", neq-string-schema(4)) == "hello"
}\
#{
  soft-parse("hello", neq-string-schema(5)) == none
}\
#{
  soft-parse("hello", neq-string-schema(6)) == "hello"
}
