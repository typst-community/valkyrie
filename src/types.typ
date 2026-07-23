#import "base-type.typ": base-type
#import "assertions.typ": one-of
#import "types/array.typ": array
#import "types/dictionary.typ": dictionary
#import "types/logical.typ": either
#import "types/number.typ": number, integer, floating-point
#import "types/sink.typ": sink
#import "types/string.typ": string, ip, email
#import "types/tuple.typ": tuple

/// see @base-type -> schema
#let alignment = base-type.with(name: "alignment", types: (alignment,))

/// see @base-type -> schema
#let angle = base-type.with(name: "angle", types: (angle,))

/// see @base-type -> schema
#let any = base-type.with(name: "any")

/// see @base-type -> schema
#let boolean = base-type.with(name: "bool", types: (bool,))

/// see @base-type -> schema
#let bytes = base-type.with(name: "bytes", types: (bytes,))

/// see @base-type -> schema
#let color = base-type.with(name: "color", types: (color,))

/// see @base-type -> schema
#let content = base-type.with(name: "content", types: (content, str, symbol))

/// see @base-type -> schema
#let date = base-type.with(name: "date", types: (datetime,))

/// see @base-type -> schema
#let direction = base-type.with(name: "direction", types: (direction,))

/// see @base-type -> schema
#let function = base-type.with(name: "function", types: (function,))

/// see @base-type -> schema
#let fraction = base-type.with(name: "fraction", types: (fraction,))

/// see @base-type -> schema
#let gradient = base-type.with(name: "gradient", types: (gradient,))

/// see @base-type -> schema
#let label = base-type.with(name: "label", types: (label,))

/// see @base-type -> schema
#let length = base-type.with(name: "length", types: (length,))

/// see @base-type -> schema
#let location = base-type.with(name: "location", types: (location,))

/// see @base-type -> schema
#let plugin = base-type.with(name: "plugin", types: (plugin,))

/// see @base-type -> schema
#let ratio = base-type.with(name: "ratio", types: (ratio,))

/// see @base-type -> schema
#let regex = base-type.with(name: "regex", types: (regex,))

/// see @base-type -> schema
#let relative = base-type.with(name: "relative", types: (relative, ratio, length))

/// see @base-type -> schema
#let selector = base-type.with(name: "selector", types: (selector,))

/// see @base-type -> schema
#let stroke = base-type.with(name: "stroke", types: (stroke,))

/// see @base-type -> schema
#let symbol = base-type.with(name: "symbol", types: (symbol,))

/// see @base-type -> schema
#let version = base-type.with(name: "version", types: (version,))

/// see @base-type -> schema
#let choice(list, assertions: (), ..args) = base-type(
  name: "enum",
  ..args,
  assertions: (one-of(list), ..assertions),
) + (
  choices: list,
)
