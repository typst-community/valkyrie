
#let ctx-proto = (
  strict: false,
  soft-error: false,
  remove-optional-none: false,
)

/// This is a utility function for setting contextual flags that are used during
/// validation of objects against schemas.   Currently, the following flags are 
/// described within the API:
/// / strict: If set, this flag adds the requirement that there are no entries in 
///     dictionary types that are not described by the validation schema.
/// / soft-error: If set, this flag silences errors from failed validation parses.
///     It is used internally for types that should not error on validation failures. 
///     See @either
/// / remove-optional-none: This flag is used to indicate that, when parsing a 
///     dictionary, if a field is marked as optional in the schema, and its value
///     is #text(fill: red, `none`), the key should be absent from the validated
///     dictionary, otherwise, that it #specifics.should be present in the validated dictionary
///     with a value of #text(fill: red, `none`)
/// -> z-ctx
#let z-ctx(
  /// The parent context from which to derive. The parent context provides the default value of any missing flags-> dictionary | default
  parent: (:), 
  /// Variadic contextual flags to set. Positional arguments are discarded. -> arguments
  ..flags
) = ctx-proto + parent + flags.named()
