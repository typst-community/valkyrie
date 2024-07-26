
/// Tested value is forceably converted to content type
///
/// #example[```
/// #let schema = z.content(
///   pre-transform: z.coerce.content
/// )
///
/// #type(z.parse("Hello", schema)) \
/// #type(z.parse(123456, schema))
/// ```]
#let content(self, it) = [#it]