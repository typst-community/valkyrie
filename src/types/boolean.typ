#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx

/// This function yields a validation schema that is satisfied only by the values `true` or `false`.
/// - default (bool, none): *OPTIONAL* default value to validate if none is provided. *MUST* itself pass
///   validation.
/// - transform (function): *OPTIONAL* mapping function called after validation.
/// -> schema
#let boolean(
  name: "bool",
  default: none,
  transform: it=>it,
) = {

    // Type safety
  assert(type(default) in (bool, type(none)),
    message: "Default of boolean must be of type boolean or none",
  )

  base-type() + (
    name: name,
    default: default,
    transform: transform,
    validate : (self, it, ctx: z-ctx(), scope: ()) => {
      // Default value
      if it == none { it = self.default }

      // assert boolean type
      if not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: ( bool, )) {
        return none
      }

      (self.transform)(it)
    }
  )

}