#import "ctx.typ": z-ctx

/// Asserts the presence of the magic number on the given object.
///
/// - arg (any):
/// - scope (scope): Array of strings containing information for error generation.
/// -> none
#let assert-base-type(arg, scope: ("arguments",)) = {
  assert("valkyrie-type" in arg,
    message: "Invalid valkyrie type in " + scope.join(".")
  )
}

/// Asserts the presence of the magic number on an array of object.
///
/// - arg (any):
/// - scope (scope): Array of strings containing information for error generation.
/// -> none
#let assert-base-type-array(arg, scope: ("arguments",)) = {
  for (name, value) in arg.enumerate() {
    assert-base-type(value, scope: (..scope, str(name)))
  }
}

/// Asserts the presence of the magic number in all entries of a dictionary of objects.
///
/// - arg (any):
/// - scope (scope): Array of strings containing information for error generation.
/// -> none
#let assert-base-type-dictionary(arg, scope: ("arguments",)) = {
  for (name, value) in arg {
    assert-base-type(value, scope: (..scope, name))
  }
}

/// Asserts the presence of the magic number in an argument of object.
///
/// - arg (any):
/// - scope (scope): Array of strings containing information for error generation.
/// -> none
#let assert-base-type-arguments(arg, scope: ("arguments",)) = {
  for (name, value) in arg.named() {
    assert-base-type(value, scope: (..scope, name))
  }

  for (pos, value) in arg.pos().enumerate() {
    assert-base-type(value, scope: (..scope, "[" + pos + "]"))
  }
}

/// Schema generator. Provides default values for when defining custom types.
#let base-type() = (

  valkyrie-type: true,

  default: none,
  types: (),
  assertions: (),
  pre-transform: (it)=>it,
  post-transform: (it)=>it,

  assert-type: (self, it, scope:(), ctx: z-ctx(), types: ()) => {

    if ( self.types.len() == 0 ) {return true};

    if ( type(it) not in self.types) {
      (self.fail-validation)(self, it, scope: scope, ctx: ctx,
        message: "Expected " + types.join(", ", last: " or ") + ". Got " + type(it))
      return false
    }

    true
  },

  handle-assertions: (self, it, scope: (), ctx: z-ctx()) => {
    for (key, value) in self.assertions.enumerate() {
      if ( value.at("precondition", default: none) != none ){
        if (self.at(value.precondition, default: none) == none){
          continue;
        }
      }
      if not ( 
        it == none or
        (value.condition)(self, it) 
      ) {
        (self.fail-validation)(
          self,
          it,
          ctx: ctx,
          scope: scope,
          message: (value.message)(self, it),
        )
        return self.default
      }
    }
    it
  },

  handle-descendents: (self, it, ctx: z-ctx(), scope: ()) => {it},

  validate: (self, it, scope: (), ctx: z-ctx()) => {
    // Default value
    it = if ( it == none ) {self.default} else {(self.pre-transform)(it)}

    // assert types
    if (not (self.assert-type)(self, it, scope: scope, ctx: ctx, types: self.types)) {
      return none
    }

    it = (self.handle-descendents)(self, it, scope: scope, ctx: ctx)

    // Custom assertions
    it = (self.handle-assertions)(self, it, scope: scope, ctx: ctx)

    (self.post-transform)(it)
  },

  fail-validation: (self, it, scope: (), ctx: z-ctx(), message: "") => {
    let display = "Schema validation failed on " + scope.join(".")
    if message.len() > 0 { display += ": " + message}
    ctx.outcome = display
    assert(ctx.soft-error, message: display)
  }
)
