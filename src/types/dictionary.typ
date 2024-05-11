#import "../base-type.typ": base-type, assert-base-type-dictionary, assert-base-type-array
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

#let dictionary-type = type((:))

/// Valkyrie schema generator for dictionary types. Named arguments define validation schema for entries. Dictionaries can be nested.
///
/// -> schema
#let dictionary(
  dictionary-schema,
  default: (:),
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
  aliases: (:)
) = {

  // Does not accept positional arguments
  //args = assert-strictly-named(args, name: "Dictionary")
  assert-base-type-dictionary(dictionary-schema)

  assert-types(default, types: (dictionary-type,), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: "dictionary",
    default: default,
    types: (dictionary-type,),
    assertions: assertions,
    pre-transform: (self, it)=>{
      let ret = pre-transform(self, it)
      for (src, dst) in aliases {
        let value = ret.at(src, default: none)
        if ( value != none ){
          ret.insert(dst, value)
          let _ = ret.remove(src)
        }
      }
      return ret
    },
    post-transform: post-transform,

    dictionary-schema: dictionary-schema,

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
      for (key, schema) in self.dictionary-schema{

        let entry = (schema.validate)(
          schema, 
          it.at(key, default: none), // implicitly handles missing entries
          ctx: ctx, 
          scope: (..scope, str(key))
        )

        // feature?: contextual flag
        //if (entry != none ) {
          it.insert(key, entry);
        //}

        // Delete optional entries that fail validation?
        if ( entry == none and it.at(key, default: none) != none) {
          it.remove(key);
        }

      }
      return it;
    },
  )
}

#let dictionary-join(
  ..dictionary-schemas,
  name: "joined-dictionary",
  default: (:),
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
  aliases: (:)
) = {

  assert-base-type-array(dictionary-schemas.pos())

  assert-types(default, types: (dictionary-type,), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: name,
    default: default,
    types: (dictionary-type,),
    pre-transform: pre-transform,
    post-transform: post-transform,

    dictionary-schemas: dictionary-schemas.pos(),

    assertions: assertions,

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
      // bug: sometimes includes 'none' for missing entries
      for (schema) in self.dictionary-schemas{
        it = (schema.validate)(
          schema,
          it,
          ctx: ctx,
          scope: scope,
        )
      }
      it;
    },

  )

}