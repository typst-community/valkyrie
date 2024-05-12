#import "./assertions/length.typ" as length
#import "./assertions/comparative.typ": *
#import "./assertions/string.typ": *

#let one-of(list) = (
  //precondition: "list",
  condition: (self, it)=>{
    list.contains(it)
  },
  message: (self, it)=> "Unknown " + self.name + " `" + repr(it) + "`"
)