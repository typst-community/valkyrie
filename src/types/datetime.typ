#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *

#let type-datetime = datetime;

#let date(
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = {

  assert-types(default, types: (type-datetime,), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: "date",
    default: default,
    types: (type-datetime,),
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

}