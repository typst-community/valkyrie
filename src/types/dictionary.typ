#import "../base-type.typ": base-type, assert-base-type-dictionary
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
  pre-transform: it=>it,
  post-transform: it=>it,
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
    assertions: (
      ( // Strict mode
        condition: (self, it) => { 
          for (key, value) in it {
            if ( key not in self.dictionary-schema ) { return false }; 
          }
          true
        },
        message: (self, it)=>"Unexpected entry with `strict` flag enabled"
      ),
      ..assertions
    ),
    pre-transform: pre-transform,
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
        if (entry != none ) {
          it.insert(key, entry)
        }

        // Delete optional entries that fail validation?
        if ( entry == none and it.at(key, default: none) != none) {
          it.remove(key)
        }

      }
      return it;
    },
  )
}