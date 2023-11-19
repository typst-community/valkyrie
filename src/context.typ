
#let context-proto = (
  strict: false,
  soft-error: false,
  coerce: false, // TO DO
)

#let context(ctx: (:), ..args) = {
  return (:..context-proto, ..ctx, ..args.named())
}