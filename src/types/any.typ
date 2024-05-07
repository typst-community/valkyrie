#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// This function yields a validation schema that should be satisfied by all inputs. It can be further 
/// specialized by providing a custom validation function and custom validation error, for the rapid 
/// implementation of novel types.
///
/// - name (internal): Used internally to generate error messages.
/// - default (any, none): *OPTIONAL* default value to validate if none is provided.
/// - custom (function): *OPTIONAL* function that maps an input to an output. If the function returns `none`,
///   then an error *WILL* be generated using `custom-error`.
/// - custom-error (string): *OPTIONAL* error to return if custom function returns none.
/// - transform (function): *OPTIONAL* function that maps an input to an output, called after validation.
/// -> schema
#let any(
  name: "any",
  default: none,
  assertions: (),
  pre-transform: it => it,
  post-transform: it => it,
) = {

  assert-types(default, types: (type(()),), name: "Default")
  assert-types(assertions, types: (type(()),), name: "Assertions")
  assert-types(pre-transform, types: (function,), name: "Pre-transform")
  assert-types(post-transform, types: (function,), name: "Post-transform")

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
