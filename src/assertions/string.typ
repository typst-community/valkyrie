#let contains(value) = {
  return (
    condition: (self, it) => it.contains(value),
    message: (self, it) => "Must contain " + str(value),
  )
}

#let starts-with(value) = {
  return (
    condition: (self, it) => it.starts-with(value),
    message: (self, it) => "Must start with " + str(value),
  )
}

#let ends-with(value) = {
  return (
    condition: (self, it) => it.ends-with(value),
    message: (self, it) => "Must end with " + str(value),
  )
}

#let matches(needle, message: (self, it) => { }) = {
  return (
    condition: (self, it) => it.match(needle) != none,
    message: message,
  )
}