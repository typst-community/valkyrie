#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx

#let content(
  name: "content",
  default: none,
  transform: (it)=>[#it],
) = {

    // Type safety
  assert(type(default) in (type(""), type([]), type(none)),
    message: "Default of content must be of type content, string or none",
  )

  base-type() + (
    name: name,
    default: default,
    transform: transform,
    validate : (self, it, ctx: z-ctx(), scope: ()) => {
      // Default value
      if it == none { it = self.default }

      // Content must be content or string
      if not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: (type(""), type([]), )) {
        return none
      }

      (self.transform)(it)
    }
  )

}