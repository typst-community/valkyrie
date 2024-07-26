/// If the tested value is not already of array type, it is transformed into an array of size 1
///
/// #example[```
/// #let schema = z.array(
///   pre-transform: z.coerce.array,
///   z.string()
/// )
///
/// #z.parse("Hello", schema) \
/// #z.parse(("Hello", "world"), schema)
/// ```]
#let array(self, it) = {
  if (type(it) != type(())) {
    return (it,)
  }
  it
}