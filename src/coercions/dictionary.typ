
/// If the tested value is not already of dictionary type, the function provided as argument is expected to return a dictionary type with a shape that passes validation.
///
/// #example[```
/// #let schema = z.dictionary(
///   pre-transform: z.coerce.dictionary((it)=>(name: it)),
///   (name: z.string())
/// )
///
/// #z.parse("Hello", schema) \
/// #z.parse((name: "Hello"), schema)
/// ```]
///
/// - fn (function): Transformation function that the tested value and returns a dictionary that has a shape that passes validation.
#let dictionary(fn) = (self, it) => {
  if (type(it) != type((:))) {
    return fn(it)
  }
  it
}