#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

#let content(
  optional: false,
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = base-type(    
    name: "content",
    optional: optional,
    default: default,
    types: (type([]),str),
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
)
