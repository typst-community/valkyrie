#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx

#let boolean(
  name: "color",
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

      // Content must be content or string
      if not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: ( bool )) {
        return none
      }

      (self.transform)(it)
    }
  )

}