#import "../base-type.typ": base-type
#import "../assertions-util.typ": assert-base-type-array
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// Valkyrie schema generator for an array type with positional type reqruiements. If all entries
/// have the same type, see @@array.
/// exact (bool): Requires a tuple to match in length
///
/// -> schema
#let tuple(
  exact: true,
  ..args,
) = {
  assert-base-type-array(args.pos())

  base-type(
    name: "tuple",
    types: (type(()),),
    ..args.named(),
  ) + (
    tuple-exact: exact,
    tuple-schema: args.pos(),
    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {

      // Issue 34: Handle differing numbers of optional elements

      // Calculate number of expected arguments
      let min-args = self.tuple-schema.filter(
        x=>{
          // I'm thinking this might cause issues with table and auto?
          // But can't think of a pleasant solution
          x.optional==false and x.default==none
        }
      ).len()
      let max-args = self.tuple-schema.len()
      let num-args = it.len()

      // Panic if the number of arguments does not match expected
      if (self.tuple-exact and (num-args > max-args or num-args < min-args)){
        (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "Expected "
            + 
            if (min-args == max-args){
              str(max-args)
            } else {
              str(min-args) + "-" + str(max-args)
            }
            +
            " values, but got " + 
            str(it.len()
          )
        )
      }

      let parsed = ()

      for (key, schema) in self.tuple-schema.enumerate() {
        parsed.insert(key, (schema.validate)(
          schema,
          it.at(key, default: none),
          ctx: ctx,
          scope: (..scope, str(key)),
        ))
      }
      return parsed
    },
  )
}
