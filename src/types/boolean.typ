#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// This function yields a validation schema that is satisfied only by the values `true` or `false`.
/// - default (bool, none): *OPTIONAL* default value to validate if none is provided. *MUST* itself pass
///   validation.
/// - transform (function): *OPTIONAL* mapping function called after validation.
/// -> schema
#let boolean(
  default: none,
  pre-transform: it=>it,
  post-transform: it=>it,
) = {

  // Type safety
  assert-types(default, types: (bool,), name: "default")
  assert-types(pre-transform, types: (function,), name: "Pre-transform")
  assert-types(post-transform, types: (function,), name: "Post-transform")

  base-type() + (
    name: "bool",
    default: default,
    pre-transform: pre-transform,
    post-transform: post-transform,
    types: ( bool, )
  )

}