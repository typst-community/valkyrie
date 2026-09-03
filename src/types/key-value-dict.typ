#import "../assertions-util.typ": assert-base-type
#import "../base-type.typ": base-type
#import "../ctx.typ": z-ctx

#let key-value-dict(
  key-schema,
  value-schema,
  name: "key-value",
  default: (:),
  ..args,
) = {
  assert-base-type(value-schema)
  assert-base-type(key-schema)

  (
    base-type(
      name: name,
      default: default,
      types: (type((:)),),
      ..args.named(),
    )
      + (
        value-schema: value-schema,
        key-schema: key-schema,
        handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
          if (it.len() == 0 and self.optional) {
            return none
          }

          for (key, value) in it.pairs() {
            let _ = (
              key-schema.validate
            )(
              key-schema,
              key,
              ctx: ctx,
              scope: (..scope, str(key)),
            )

            let _ = (
              value-schema.validate
            )(
              value-schema,
              value,
              ctx: ctx,
              scope: (..scope, str(key), repr(value)),
            )
          }

          return it
        },
      )
  )
}
