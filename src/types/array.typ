#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

#import "any.typ": any
#import "dictionary.typ": dictionary

#let array-type = type(())

/// This function yields a validation schema that is satisfied by an array of entries than themselves
/// satisfy the schema defined in the sink argument. Array entries are validated by a single schema. 
/// For arrays with positional requirements, see @@tuple. If no schema for child entries is provided,
/// entries are validated against @@any.
///
/// -> schema
#let array(
  name: "array",
  default: (),
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
  ..args
) = {

  assert-types(default, types: (array-type,), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  // refactor(james): Is there a better way of doing this?
  let descendents-schema = args.pos().at(0, default: any())

  if ( not descendents-schema.at( "valkyrie-type", default: false) ){
    descendents-schema = dictionary(..descendents-schema)
  }

  // todo(james): This is a good opportunity to check if its a dictionary of schemas
  //        and it could just be converted to a @@dictionary schema
  assert-base-type(descendents-schema, scope: ("arguments",))

  let name = name + "[" + (descendents-schema.name) +"]";

  base-type() + (
    name: name,
    default: default,
    types: (array-type,),
    pre-transform: pre-transform,
    post-transform: post-transform,

    descendents-schema: descendents-schema,

    assertions: assertions,

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
      // bug: sometimes includes 'none' for missing entries
      for (key, value) in it.enumerate(){
        it.at(key) = (descendents-schema.validate)(
          descendents-schema,
          value,
          ctx: ctx,
          scope: (..scope, str(key)),
        )
      }
      it;
    },

  )
}