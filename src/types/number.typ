#import "../base-type.typ": base-type, assert-base-type
#import "../context.typ": context

#let number(
  default: none,
  min: none,
  max: none,
  custom: none, // function, none
  custom-error: auto, // string, auto
  transform: it=>it, // function(number)=>number
  types: (float, int),
  name: "number"
) = {

  // Type safety
  assert( type(default) in (..types, type(none)),
    message: "Default of number must be of type integer, float, or none (possibly narrowed)")
  assert( type(min) in (int, float, type(none)), message: "Minimum value must be an integer or float")
  assert( type(max) in (int, float, type(none)), message: "Maximum value must be an integer or float")

  assert( type(custom) in (function, type(none)), message: "Custom must be a function")
  assert( type(custom-error) in (str, type(auto)), message: "Custom-error must be a string")
  assert( type(transform) == function, message: "Transform must be a function that takes a single number and return a number")

  return (:..base-type(),
    name: name,
    default: default,
    min: min,
    max: max,
    custom: custom,
    custom-error: custom-error,
    transform: transform,
    types: types,

    validate: (self, it, ctx: context(), scope: ()) => {

      // TO DO: Coercion

      // Default value
      if ( it == none ){ it = self.default }

      // Assert type
      if not (self.assert-type)(self, it, ctx: ctx, scope: scope, types: types){
        return none
      }

      // Minimum value
      if ( self.min != none ) and (it < self.min ){
        return (self.fail-validation)( self, it, ctx: ctx, scope: scope,
          message: "Value less than specified minimum of " + str(self.min))
      }

      // Maximum value
      if ( self.max != none ) and (it > self.max ){
        return (self.fail-validation)( self, it, ctx: ctx, scope: scope,
          message: "Value greater than specified maximum of " + str(self.max))
      }

      // Custom
      if ( self.custom != none ) and ( not (self.custom)(it) ){
        let message = "Failed on custom check: " + repr(self.custom)
        if ( self.custom-error != auto ){ message = self.custom-error }
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, message: message)
      }

      return (self.transform)(it)
    }
  )
}

#let integer = number.with( name: "integer", types: (int,))
#let floating-point = number.with( name: "float", types: (float,))

#let natural = number.with( name: "natural number", types: (int,), min: 0)