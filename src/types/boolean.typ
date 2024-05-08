#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// This function yields a validation schema that is satisfied only by the values `true` or `false`.
/// 
/// -> schema
#let boolean(
  default: none,
  pre-transform: it=>it,
  post-transform: it=>it,
) = {

  // Type safety
  assert-types(default, types: (bool,), name: "Default")
  assert-boilerplate-params(
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: "bool",
    default: default,
    pre-transform: pre-transform,
    post-transform: post-transform,
    types: ( bool, )
  )

}