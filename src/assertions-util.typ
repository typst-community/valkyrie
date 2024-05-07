
#let assert-types(var, types: (), default: none, name: "") = {
  //panic(name + " must be of type " + types.join(", ", last: " or ") + ". Got " + type(var))
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