#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

#let type-color = type(rgb(0,0,0));

#let color(
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = {

  assert-types(default, types: (type-color,), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: "color",
    default: default,
    types: (type-color,),
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

}