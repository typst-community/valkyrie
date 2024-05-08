#import "../base-type.typ": base-type, assert-base-type-dictionary
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// Valkyrie schema generator for dictionary types. Named arguments define validation schema for entries. Dictionaries can be nested.
///
/// -> schema
#let dictionary(
  ..args
) = {

  // Does not accept positional arguments
  args = assert-strictly-named(args, name: "Dictionary")
  assert-base-type-dictionary(args)

  base-type() + (
    name: "dictionary",
    default: (:),
    types: (type((:)),),
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
    ),

    dictionary-schema: args,

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
      for (key, schema) in self.dictionary-schema{
        it.insert(
          key, 
          (schema.validate)(
            schema, 
            it.at(key, default: none), // implicitly handles missing entries
            ctx: ctx, 
            scope: (..scope, str(key))
          )
        )
      }
      it;
    },
  )
}