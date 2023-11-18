#import "context.typ": context

#let assert-base-type(t, scope: ("arguments",)) = {
  assert("valkyrie-type" in t,
    message: "Invalid valkyrie type in " + scope.join(".")
  )
}

#let assert-base-type-dictionary(args, scope: ("arguments",)) = {
  for (name, value) in args{ 
    assert-base-type(value, scope: (..scope, name)) 
  }
}

#let assert-base-type-arguments(args, scope: ("arguments",)) = {
  for (name, value) in args.named(){ 
    assert-base-type(value, scope: (..scope, name)) 
  }
  
  for (pos, value) in args.pos().enumerate(){ 
    assert-base-type(value, scope: (..scope, "[" + pos + "]")) 
  }
}

#let joinWithAnd(arr, join, with) = {
  if ( arr.len() <= 1 ){ return arr.first() }
  let last = arr.pop(); return arr.join(join) + with + last
}

#let base-type() = {
  return (
    valkyrie-type: true,
    
    assert-type: (self, it, scope:(), ctx: context(), types: ()) => {
      if ( type(it) not in types){
        (self.fail-validation)(self, it, scope: scope, ctx: ctx,
          message: "Expected " + joinWithAnd(types, ", ", " or ") + ". Got " + type(it))
        return false
      }
      return true
    },
    
    validate: (self, it, scope: (), ctx: (:)) => it,
    
    fail-validation: (self, it, scope: (), ctx: (:), message: "") => {
      let display = "Schema validation failed on " + scope.join(".")
      if ( message.len() > 0){ display += ": " + message}
      ctx.outcome = display
      if ( not ctx.soft-error ) {
        assert(false, message: display)
      }
    }
  )
}