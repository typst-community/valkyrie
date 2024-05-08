#import "../assertions-util.typ": *

#let min(rhs) = {
  assert-positive-type(rhs, types: (int,), name: "Minimum length")

  return (
    condition: (self, it)=>it.len()>=rhs, 
    message: (self, it) => "Length must be at least " + str(rhs),
  )
}

#let max(rhs) = {
  assert-positive-type(rhs, types: (int,), name: "Maximum length")

  return (
    condition: (self, it)=>it.len()<=rhs, 
    message: (self, it) => "Length must be at most " + str(rhs),
  )
}

#let equals(rhs) = {
  assert-positive-type(rhs, types: (int,), name: "Maximum length")

  return (
    condition: (self, it)=>it.len()==rhs, 
    message: (self, it) => "Length must equal " + str(rhs),
  )
}