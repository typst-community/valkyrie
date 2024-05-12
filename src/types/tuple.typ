#import "../base-type.typ": base-type, assert-base-type-array
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// Valkyrie schema generator for an array type with positional type reqruiements. If all entries
/// have the same type, see @@array.
///
/// -> schema
#let tuple(
  name: "tuple",
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
  ..args
) = {

  // Does not accept named arguments
  args = assert-strictly-positional(args, name: "Tuple")
  assert-base-type-array(args)

  base-type(
    name: name,
    types: (type(()),),
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  ) + (

    tuple-schema: args,

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
      for (key, schema) in self.tuple-schema.enumerate() {
        it.at(key) = (schema.validate)(
          schema,
          it.at(key),
          ctx: ctx,
          scope: (..scope, str(key))
        )
      }
      it;
    },
  )
}
