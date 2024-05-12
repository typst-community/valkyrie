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
  optional: false,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
  aliases: (:)
) = {

  assert-base-type-dictionary(dictionary-schema)

  base-type(
    name: "dictionary",
    optional: optional,
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
  ) + (
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
        if (entry != none ) {
          it.insert(key, entry);
        }

        // Delete optional entries that fail validation?
        if ( entry == none and it.at(key, default: none) != none) {
          it.remove(key);
        }

      }
      return it;
    },
  )
}