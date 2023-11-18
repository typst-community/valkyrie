#import "../base-type.typ": base-type, assert-base-type
#import "../context.typ": context

#let string(
  default: none, // string, none
  min: none, // integer, none
  max: none, // integer, none
  length: auto, // integer, auto
  includes: (), // string, array, regex
  starts-with: none, // string, regex, none
  ends-with: none, // string, regex, none
  pattern: none, // regex, string
  pattern-error: auto, // string, auto
  transform: it=>it, // function(string)=>string
  name: "string" // String
) = {

  // Program is ill-formed if length is set at the same time as min or max
  
  // Type safety
  assert( type(default) in (str, type(none)),
    message: "Default of string must be of type string or none")
    
  assert( type(min) in (int, type(none)), message: "Minimum length must be an integer")
  if ( min != none){ assert( min >= 0, message: "Minimum length must be a positive integer")}

  assert( type(max) in (int, type(none)), message: "Maximum length must be an integer")
  if ( max != none){assert( max >= 0, message: "Maximum length must be a positive integer")}

  assert( type(length) in (int, type(auto)), message: "Length must be an integer")
  if ( length != auto){assert( length >= 0, message: "Maximum length must be a positive integer")}

  if ( type(includes) == str) { includes = (includes,)}
  assert( type(includes) == array, message: "Includes must be an array of string or regex primitives" )
  for each in includes{
    assert( type(each) in (str, regex), message: "Includes must be an array of string or regex primitives" )
  }
  
  assert( type(starts-with) in (str, regex, type(none)), message: "Starts-with must be of type string or regex")
  assert( type(ends-with) in (str, regex, type(none)), message: "Ends-with must be of type string or regex")
  assert( type(pattern) in (regex, type(none)), message: "Pattern must be of type regex")
  assert( type(pattern-error) in (str, type(auto)), message: "Pattern-error must be a string")
  assert( type(transform) == function, message: "Transform must be a function that takes a single string and return a string")
  
  let fail(self, it, ctx: context(), scope: (), message: "") = {
    assert(false, message: "Schema validation failed on " + scope.join(".") + ": " + message)
  }

  return (:..base-type(),
    name: name,
    default: default,
    min: min,
    max: max,
    length: length,
    includes: includes,
    starts-with: starts-with,
    ends-with: ends-with,
    pattern: pattern,
    pattern-error: pattern-error,
    transform: transform,
    
    validate: (self, it, ctx: context(), scope: ()) => {

      // Default value
      if (it == none){ it = self.default }

      // String must be a string
      if not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: (str,)){
        return none
      }
      
      // Minimum length
      if (self.min != none) and (it.len() < self.min) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "String length less than specified minimum of " + str(self.min))
      }

      // Minimum length
      if (self.max != none) and (it.len() > self.max) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "String length greater than specified maximum of " + str(self.max))
      }
      
      // Exact length
      if (self.length != auto) and (it.len() != self.length) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "String length must exactly equal " + str(self.length))
      }
      
      // Includes
      for required-include in self.includes {
        if not it.contains(required-include){
          return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
            message: "String must include " + str(required-include))
        }
      }
      
      // startswith
      if (self.starts-with != none) and not it.starts-with(self.starts-with) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "String must start with " + str(self.starts-with))
      }
      
      // ends with
      if (self.ends-with != none) and not it.ends-with(self.ends-with) {
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, 
          message: "String must end with " + str(self.ends-with))
      }

      // regex
      if ( self.pattern != none ) and (it.match(self.pattern) == none){
        let message = "String failed to match following pattern: " + repr(self.pattern)
        if ( self.pattern-error != auto ){ message = self.pattern-error }
        return (self.fail-validation)(self, it, ctx: ctx, scope: scope, message: message)
      }
      
      return (self.transform)(it)
    }
  )
}

#let email = string.with(
  name: "email",
  pattern: regex("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]{2,3}){1,2}$"),
  pattern-error: "String must be an email address"
)

// TO DO: url
// TO DO: emoji
// TO DO: uuid

#let ip = string.with(
  name: "ip",
  pattern: regex("^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"),
  pattern-error: "String must be a valid IP address"
)

// Transformations:
#let transform-trim = string.with(transform: str.trim)
#let transform-lowercase = string.with(transform: lower)
#let transform-uppercase = string.with(transform: upper)