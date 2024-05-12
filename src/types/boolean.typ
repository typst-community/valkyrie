#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

/// This function yields a validation schema that is satisfied only by the values `true` or `false`.
/// 
/// -> schema
#let boolean(
  optional: false,
  default: none,
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = base-type(    
  name: "bool",
  default: default,
  optional: optional,
  pre-transform: pre-transform,
  post-transform: post-transform,
  types: (bool,)
)