#let stdversion = version

/// Tested value is forceably converted to version type
///
/// #example[```
/// #let schema = z.version(
///   pre-transform: z.coerce.version
/// )
///
/// #type(z.parse("0.1.1", schema)) \
/// #type(z.parse(1, schema))
/// #type(z.parse((1,1,), schema))
/// ```]
#let version(self, it) = {
  if type(it) == str {
    return stdversion(
      it.split(".")
        .filter(it=>it!="")
        .map(int)
    )
  } else if type(it) == int {
    return stdversion(it)
  } else if type(it) == array {
    return stdversion(it.map(int))
  } 
  it
}