#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx

#let color(
  name: "color",
  default: none,
  transform: it=>it,
) = {

    // Type safety
  assert(type(default) in (type(rgb(0,0,0)), type(none)),
    message: "Default of color must be of type color or none",
  )

  base-type() + (
    name: name,
    default: default,
    transform: transform,
    validate : (self, it, ctx: z-ctx(), scope: ()) => {
      // Default value
      if it == none { it = self.default }

      // Content must be content or string
      if not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: ( type(rgb(0,0,0)), )) {
        return none
      }

      (self.transform)(it)
    }
  )

}