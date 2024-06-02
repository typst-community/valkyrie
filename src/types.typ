#import "base-type.typ": base-type
#import "assertions.typ": one-of
#import "types/array.typ": array
#import "types/dictionary.typ": dictionary
#import "types/logical.typ": either
#import "types/string.typ": string, ip, email
#import "types/tuple.typ": tuple

#let alignment = base-type.with(name: "bool", types: (alignment,))
#let any = base-type.with(name: "any")
#let boolean = base-type.with(name: "bool", types: (bool,))
#let bytes = base-type.with(name: "bytes", types: (bytes,))
#let color = base-type.with(name: "color", types: (color,))
#let content = base-type.with(name: "content", types: (content, str))
#let date = base-type.with(name: "date", types: (datetime,))
#let function = base-type.with(name: "function", types: (function,))
#let gradient = base-type.with(name: "gradient", types: (gradient,))
#let label = base-type.with(name: "label", types: (label,))
#let location = base-type.with(name: "location", types: (location,))
#let regex = base-type.with(name: "regex", types: (regex,))
#let selector = base-type.with(name: "selector", types: (selector,))
#let stroke = base-type.with(name: "stroke", types: (stroke,))
#let symbol = base-type.with(name: "symbol", types: (symbol,))
#let version = base-type.with(name: "version", types: (version,))

#let number = base-type.with(name: "number", types: (float, int))
#let integer = number.with(name: "integer", types: (int,))
#let floating-point = number.with(name: "float", types: (float,))

#let choice(list, assertions: (), ..args) = base-type(
  name: "enum",
  ..args,
  assertions: (one-of(list), ..assertions),
)
