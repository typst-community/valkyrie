#import "/src/lib.typ" as z
#import "/tests/utility.typ": *

#show: show-rule.with();

#let schema = z.version()

= types/version
== Input types
#z.parse(version(0,1,0), schema)