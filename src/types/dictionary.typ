#import "../base-type.typ": base-type, assert-base-type-dictionary
#import "../ctx.typ": z-ctx

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
/// - ..args (schema): Variadic named arguments, the values for which are schema types. *MUST* not
///   contain positional arguments. Argument name *MUST* match key name in dictionary type being validated. Argument value *MUST* be a schema type.
/// -> schema
///
#let dictionary(
  ..args
) = {
  // Does not accept positional arguments
  assert(args.pos().len() == 0, message: "Dictionary only accepts named arguments")

  args = args.named()
  assert-base-type-dictionary(args)

  base-type() + (
    name: "dictionary",
    dictionary-schema: args,
    validate: (self, dict, ctx: z-ctx(), scope: ("arguments",) ) => {
      
      if (dict == none){ dict = (:)}
      
      // assert type
      if not (self.assert-type)(self, dict, scope: scope, ctx: ctx, types: (type((:)),)) {
        return none
      }

      // If strict mode, ensure dictionary exactly matches schema
      if ctx.strict {
        for (key, value) in dict {
          if ( key not in self.dictionary-schema ){
            (self.fail-validation)(self, dict, ctx: ctx, scope: (..scope, key), message: "Unexpected entry with `strict` flag enabled")
          }
        }
      }

      // Check elements
      for (key, schema) in self.dictionary-schema{
        dict.insert(key, (schema.validate)(
          schema, 
          dict.at(key, default: none), 
          ctx: ctx, 
          scope: (..scope, str(key))))
      }

      dict
    }
  )
}
