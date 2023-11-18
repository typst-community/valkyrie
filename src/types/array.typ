#import "../base-type.typ": base-type, assert-base-type
#import "../context.typ": context
#import "any.typ": any

#let array(
  name: "array", 
  default: (),
  min: none, // integer, none
  max: none, // integer, none
  length: auto, // integer, auto
  custom: none, // regex, string
  custom-error: auto, // string, auto
  transform: it=>it, // function(string)=>string
  ..args
) = {

  // assert default is array

  assert( type(min) in (int, type(none)), message: "Minimum length must be an integer")
  if ( min != none){ assert( min >= 0, message: "Minimum length must be a positive integer")}

  assert( type(max) in (int, type(none)), message: "Maximum length must be an integer")
  if ( max != none){assert( max >= 0, message: "Maximum length must be a positive integer")}

  assert( type(length) in (int, type(auto)), message: "Length must be an integer")
  if ( length != auto){assert( length >= 0, message: "Maximum length must be a positive integer")}

  assert( type(custom) in (function, type(none)), message: "Custom must be of type regex")
  assert( type(custom-error) in (str, type(auto)), message: "Custom-error must be a string")
  assert( type(transform) == function, message: "Transform must be a function that takes a single string and return a string")

  let positional-arguments = args.pos()
  
  let valkyrie-array-typ 
  if ( positional-arguments.len() < 1 ){
    valkyrie-array-typ = any()
  } else {
    valkyrie-array-typ = positional-arguments.first()
    assert-base-type(valkyrie-array-typ, scope: ("arguments",))
  }

  let name = name + "[" + (valkyrie-array-typ.name) +"]"
  
  return (:..base-type(),
    name: name,
    default: default,
    min: min,
    max: max,
    length: length,

    valkyrie-array-typ: valkyrie-array-typ,
    
    custom: custom,
    custom-error: custom-error,
    transform: transform,
    
    validate: (self, it, ctx: context(), scope: ()) => {

      // Default value
      if (it == none){ it = self.default }

      // Array must be an array
      if not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: (type(()),)){
        return none
      }

      // Minimum length
      if (self.min != none) and (it.len() < self.min) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "Array length less than specified minimum of " + str(self.min))
      }

      // Minimum length
      if (self.max != none) and (it.len() > self.max) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "Array length greater than specified maximum of " + str(self.max))
      }
      
      // Exact length
      if (self.length != auto) and (it.len() != self.length) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "Array length must exactly equal " + str(self.length))
      }

      // Check elements
      for (key, value) in it.enumerate(){
        it.at(key) = (valkyrie-array-typ.validate)(valkyrie-array-typ, value, ctx: ctx, scope: (..scope, str(key)))
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