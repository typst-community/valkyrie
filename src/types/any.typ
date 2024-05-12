#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// This function yields a validation schema that should be satisfied by all inputs. It can be further 
/// specialized by providing a custom validation function and custom validation error, for the rapid 
/// implementation of novel types.
///
/// -> schema
#let any(
  name: "any",
  optional: false,
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = {

  base-type(
    name: name,
    optional: optional,
    default: default,
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )
}
