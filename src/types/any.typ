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
  default: none,
  assertions: (),
  pre-transform: it => it,
  post-transform: it => it,
) = {

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: name,
    default: default,
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
    assert-type: (self, it, scope:(), ctx: z-ctx(), types: ()) => {
      true
    },
  )
}
