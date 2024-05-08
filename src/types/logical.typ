#import "../base-type.typ": base-type, assert-base-type, assert-base-type-array
#import "../ctx.typ": z-ctx

/// Valkyrie schema generator for objects that can be any of multiple types.
///
/// -> schema
#let either(..options) = {
  let options = options.pos()

  assert(options.len() > 0 , message: "z.either requires 1 or more arguments.")
  assert-base-type-array(options, scope: ("arguments",))

  let name = "[" + options.map(it => it.name).join( ", ", last: " or ") + "]"

  base-type() + (
    name: name,
    options: options,
    validate: (self, it, ctx: z-ctx(), scope: ()) => {
      for option in self.options {
        let ret = (option.validate)(option, it, ctx: z-ctx(ctx, soft-error: true), scope: scope)
        if ret != none { return ret }
      }

      let message = ("Type failed to match any of possible options: "
        + self.options.map(it => it.name).join(", ", last: " or ") + ". Got " + type(it))

      (self.fail-validation)(self, it, ctx: ctx, scope: scope, message: message)
    }
  )
}


#let optional(option) = {

  assert-base-type(option, scope: ("arguments",))
  // todo(james): Probably a better naming convention that this
  let name = "<optional>" + option.name

  // todo: Change design. Somehow detect if there was an error and discard value?

  base-type() + (
    name: name,
    validation: (self, it, ctx: z-ctx(), scope: ()) => {
      let ret = (option.validate)(option, it, ctx: z-ctx(ctx, soft-error: true), scope: scope)
      if ret != none { return ret }
      // return auto;
    }
  )

}