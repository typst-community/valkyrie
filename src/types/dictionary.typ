#import "../base-type.typ": base-type, assert-base-type-dictionary
#import "../ctx.typ": z-ctx

// todo(james): Positional arguments used for post processing?
// todo(james): reformulate with new base structure

/// Valkyrie schema generator for dictionary types. Named arguments define validation schema for entries. Dictionaries can be nested.
///
/// #example(`
/// #let schema = z.dictionary(
///   key1: z.string(),
///   key2: z.number()
///);
/// #z.parse((key1: "hello", key2: 0), schema)
///`)
///
/// - ..args (schema): Variadic named arguments, the values for which are schema types. *MUST NOT* 
///   contain positional arguments. Argument name *MUST* match key name in dictionary type being validated. Argument value *MUST* be a schema type.
/// -> schema
///
#let dictionary(
  ..args
) = {

  // todo(james): args = assert-strictly-named(args)
  // Does not accept positional arguments
  assert(args.pos().len() == 0, message: "Dictionary only accepts named arguments")

  args = args.named()
  assert-base-type-dictionary(args)

  base-type() + (
    name: "dictionary",
    dictionary-schema: args,
    default: (:),
    types: (type((:)),),
    assertions: (
      ( // Strict mode
        condition: (self, it) => { 
          for (key, value) in it {
            if ( key not in self.dictionary-schema ) { return false}; 
          }
          true
        },
        message: (self, it)=>"Unexpected entry with `strict` flag enabled"
      ),
      ( // Check descendents
        condition: (self, it) => { return true },
        message: ""
      ),
    ),

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
      for (key, schema) in self.dictionary-schema{
        it.insert(
          key, 
          (schema.validate)(
            schema, 
            it.at(key, default: none), 
            ctx: ctx, 
            scope: (..scope, str(key))
          )
        )
      }
      it;
    },
  )
}