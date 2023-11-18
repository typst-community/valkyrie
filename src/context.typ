
#let context-proto = (
  strict: false,
  soft-error: false,
)

#let context(ctx: (:), ..args) = {
  return (:..context-proto, ..ctx, ..args.named())
}