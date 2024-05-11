#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

#let type-content = type([]);

#let content(
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = {

  assert-types(default, types: (type-content,str), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: "content",
    default: default,
    types: (type-content,str),
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

}