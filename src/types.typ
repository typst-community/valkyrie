#import "base-type.typ": base-type
#import "assertions.typ": one-of

#let any = base-type.with(name: "any")

#import "types/array.typ": *

#let boolean = base-type.with(name: "bool", types: (bool,))

#let color = base-type.with( name: "color", types: (type(rgb(0,0,0)),)) 
#let content = base-type.with(name: "content", types: (type([]),str))
#let date = base-type.with(name: "date", types: (datetime,))

#import "types/dictionary.typ": dictionary
#import "types/logical.typ": either

#let number = base-type.with( name: "number", types: (float, int))

/// Specialization of @@number() that is only satisfied by whole numbers. Parameters of @@number remain available for further requirments.
#let integer = number.with( name: "integer", types: (int,))

/// Specialization of @@number() that is only satisfied by floating point numbers. Parameters of @@number remain available for further requirments.
#let floating-point = number.with( name: "float", types: (float,))

#import "types/string.typ": string, ip, email
#import "types/tuple.typ": *

#let choice(list, assertions: (), ..args) = any(
  name: "enum",
  ..args,
  assertions: (one-of(list),..assertions),
)
