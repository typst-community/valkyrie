
#let ctx-proto = (
  strict: false,
  soft-error: false,
  coerce: false, // TO DO
)

/// Appends setting to ctx. Used for setting the ctx of child parses.
///
/// - ctx (ctx, none): Current ctx (if present, or undefined if not), to which ctxual flags passed in variadic arguments are appended.
/// - ..args (arguments): Variadic ctxual flags to set. While it accepts positional arguments, only named ctxual flags are used throughout the codebase.
#let ctx(ctx: (:), ..args) = {
  return (:..ctx-proto, ..ctx, ..args.named())
}
