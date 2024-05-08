
#let assert-types(var, types: (), default: none, name: "") = {
  assert(
    type(var) in (type(default), ..types),
    message: "" + name + " must be of type " + types.join(", ", last: " or ") + ". Got " + type(var)
  )
}

#let assert-soft(var, condition: ()=>true, message: "") = {
  if (var != none){
    assert(condition(var), message: message)
  }
}

#let assert-positive(var, name: "") = {
  assert-soft(var, condition: (var)=>var>=0, message: name + " must be positive")
}

#let assert-positive-type(var, name: "", types: (), default: none) = {
  assert-types(var, types: types, default: default, name: name);
  assert-positive(var, name: name);
}

#let assert-strictly-named(args, name: "") = {
  assert(args.pos().len() == 0, message: name + " only accepts named arguments")
  return args.named()
}

#let assert-strictly-positional(args, name: "") = {
  assert(args.named().len() == 0, message: name + " only accepts positional arguments")
  return args.pos()
}

#let assert-boilerplate-params(
  default: none,
  assertions: none,
  pre-transform: none,
  post-transform: none,
) = {
  if ( assertions != none ) {assert-types(assertions, types: (type(()),), name: "Assertions")}
  if ( pre-transform != none ) {assert-types(pre-transform, types: (function,), name: "Pre-transform")}
  if ( post-transform != none ) {assert-types(post-transform, types: (function,), name: "Post-transform")}
}