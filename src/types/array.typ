#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *
#import "any.typ": any

/// This function yields a validation schema that is satisfied by an array of entries than themselves
/// satisfy the schema defined in the sink argument. Array entries are validated by a single schema. 
/// For arrays with positional requirements, see @@tuple. If no schema for child entries is provided,
/// entries are validated against @@any.
///
/// - name (internal): Used internally to generate error messages.
/// - default (array, none): *OPTIONAL* default value to validate if none is provided. *MUST* itself pass
///   validation.
/// - min (integer, none): *OPTIONAL* minimum array length that satisfies the validation.
///   *MUST* be a positive integer. The program is *ILL-FORMED* if `min` is greater than `max`.
/// - max (integer, none): *OPTIONAL* maximum array length that satisfies the validation.
///   *MUST* be a positive integer. The program is *ILL-FORMED* if `max` is less than `min`.
/// - length (integer, auto): *OPTIONAL* exact array length that satisfies validation. *MUST*
///   be a positiive integer. The program *MAY* be *ILL-FORMED* is concurrently set with either
///   `min` or `max`.
/// - transform (function): *OPTIONAL* mapping function called after validation.
/// - ..args (schema, none): Variadic positional arguments of length `0` or `1`. *SHOULD* not
///   contain named arguments. If no arguments are given, schema defaults to array of @@any
/// -> schema
#let array(
  name: "array",
  default: (),
  assertions: (),
  min: none,
  max: none,
  length: none,
  pre-transform: it=>it,
  post-transform: it=>it,
  ..args
) = {
  assert-positive-type(min, types: (int,), name: "Minimum length")
  assert-positive-type(max, types: (int,), name: "Maximum length")
  assert-positive-type(length, types: (int,), name: "Length")

  assert-types(default, types: (type(()),), name: "Default")
  assert-types(assertions, types: (type(()),), name: "Assertions")
  assert-types(pre-transform, types: (function,), name: "Pre-transform")
  assert-types(post-transform, types: (function,), name: "Post-transform")

  let descendents-schema = args.pos().at(0, default: any())

  // todo(james): This is a good opportunity to check if its a dictionary of schemas
  //        and it could just be converted to a @@dictionary schema
  assert-base-type(descendents-schema, scope: ("arguments",))

  let name = name + "[" + (descendents-schema.name) +"]";

  base-type() + (
    name: name,
    default: default,
    types: (type(()),),

    pre-transform: pre-transform,
    post-transform: post-transform,

    min: min,
    max: max,
    length: length,
    descendents-schema: descendents-schema,

    assertions: (
      (
        precondition: "min",
        condition: (self, it)=>it.len()>=self.min, 
        message: (self) => "Array length must be at least " + str(self.min),
      ),
      (
        precondition: "max",
        condition: (self, it)=>it.len()<=self.max, 
        message: (self) => "Array length must be at most " + str(self.max),
      ),
      (
        precondition: "length",
        condition: (self, it)=>it.len()==self.length, 
        message: (self) => "Array length must be exactly " + str(self.length),
      ),
      ..assertions
    ),

    handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {
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
