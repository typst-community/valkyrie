#import "../base-type.typ": base-type, assert-base-type
#import "../context.typ": context

#let either( ..options ) = {
  let options = options.pos()

  assert( options.len() > 0 , message: "z.either requires 1 or more arguments.")

  for option in options {
    assert-base-type(option, scope: ("arguments",))
  }

  return (:..base-type(),
    validate: (self, it, ctx: context(), scope: ()) => {
      for option in options {
        let ret = (option.validate)(option, it, ctx: context(ctx, soft-error: true), scope: scope)
        if ( ret != none ){ return ret }
      }
      // Somehow handle error? Not sure how to retrieve from ctx
      return (self.fail-validation)(self, it, ctx: ctx, scope: scope,
          message: "Type failed to match any of possible options: " + options.map(it=>it.name).join(", "))
    }
  )
}