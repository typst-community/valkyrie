#import "types.typ": *
#import "context.typ": context

#let parse(
  args, schema,
  ctx: context(),
  scope: ("argument",),
) = {

  // Type safety
  let named-arguments = (if type(args) == arguments {args.named()} else {args})
  
  // don't expose to external
  import "base-type.typ": assert-base-type
  
  // Validate named arguments
  assert-base-type(schema, scope: scope)

  // Validate arguments per schema
  args = (schema.validate)(
      schema, 
      ctx: ctx, 
      scope: scope,
      named-arguments)

  // Require arguments match schema exactly in strict mode
  if ( ctx.strict ){ for (argument-name, argument-value) in named-arguments.named() {
      assert( argument-name in schema, message: "Unexpected argument " + argument-name)
  }}

  return args
}

