#import "../base-type.typ": base-type, assert-base-type
#import "../context.typ": context

#let any(
  name: "any", 
  default: none,
  custom: none, // regex, string
  custom-error: auto, // string, auto
  transform: it=>it, // function(string)=>string
  ..args
) = {

  assert( type(custom) in (function, type(none)), message: "Custom must be a function")
  assert( type(custom-error) in (str, type(auto)), message: "Custom-error must be a string")
  assert( type(transform) == function, message: "Transform must be a function that maps an input to an output")
  
  return (:..base-type(),
    name: name,
    default: default,    
    custom: custom,
    custom-error: custom-error,
    transform: transform,
    
    validate: (self, it, ctx: context(), scope: ()) => {

      // Default value
      if (it == none){ it = self.default }

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