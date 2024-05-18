#import "../assertions-util.typ": *

#let min(rhs) = {
  assert-positive-type(rhs, types: (int,), name: "Minimum")

  return (
    condition: (self, it)=>it>=rhs, 
    message: (self, it) => "Must be at least " + str(rhs),
  )
}

#let max(rhs) = {
  assert-positive-type(rhs, types: (int,), name: "Maximum")

  return (
    condition: (self, it)=>it<=rhs, 
    message: (self, it) => "Must be at most " + str(rhs),
  )
}


#let eq(rhs) = {
  assert-positive-type(rhs, types: (int,), name: "Equality")

  return (
    condition: (self, it)=>it==rhs, 
    message: (self, it) => "Must be exactly " + str(rhs),
  )
}