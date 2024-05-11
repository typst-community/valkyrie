#import "../base-type.typ": base-type, assert-base-type
#import "../ctx.typ": z-ctx
#import "../assertions-util.typ": *
#import "../assertions/string.typ": matches

/// Valkyrie schema generator for strings
///
/// -> schema
#let string(
  name: "string",
  default: none,
  assertions: (),
  pre-transform: (self, it) => it,
  post-transform: (self, it) => it,
) = {
  
  assert-types(default, types: (str,), name: "Default")

  assert-boilerplate-params(
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )

  base-type() + (
    name: name,
    default: default,
    types: (str,),
    assertions: assertions,
    pre-transform: pre-transform,
    post-transform: post-transform,
  )
}


#let ip = string.with( 
  name: "email",
  assertions: (
    matches(
      regex("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]{2,3}){1,2}$"),
      message: (self, it)=>"Must be an email address"
    ),
  )
);

// TODO(james): url
// TODO(james): emoji
// TODO(james): uuid

#let ip = string.with( 
  name: "ip",
  assertions: (
    matches(
      regex("^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"),
      message: (self, it)=>"Must be a valid IP address"
    ),
  )
);

#let email = string;
