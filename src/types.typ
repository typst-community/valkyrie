#import "base-type.typ": base-type
#import "assertions.typ": one-of
#import "types/array.typ": array
#import "types/dictionary.typ": dictionary
#import "types/logical.typ": either
#import "types/number.typ": number, integer, floating-point
#import "types/sink.typ": sink
#import "types/string.typ": string, ip, email
#import "types/tuple.typ": tuple

#let any = base-type.with(name: "any")
#let boolean = base-type.with(name: "bool", types: (bool,))
#let color = base-type.with(name: "color", types: (color,))
#let content = base-type.with(name: "content", types: (content, str, symbol))
#let date = base-type.with(name: "date", types: (datetime,))

#let choice(list, assertions: (), ..args) = base-type(
  name: "enum",
  ..args,
  assertions: (one-of(list), ..assertions),
)
