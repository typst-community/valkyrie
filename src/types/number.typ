#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// Valkyrie schema generator for integer- and floating-point numbers
///
/// -> schema
#let number(
  name: "enum",
  default: none,
  assertions: (),
  pre-transform: it=>it,
  post-transform: it=>it,
  types: (float, int),
) = {
  // Type safety
  assert-types(default, types: types, name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: name,
    default: default,
    types: types,
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )
}

/// Specialization of @@number() that is only satisfied by whole numbers. Parameters of @@number remain available for further requirments.
#let integer = number.with( name: "integer", types: (int,))

/// Specialization of @@number() that is only satisfied by floating point numbers. Parameters of @@number remain available for further requirments.
#let floating-point = number.with( name: "float", types: (float,))