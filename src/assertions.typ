#import "./assertions/length.typ" as length
#import "./assertions/comparative.typ": min, max, eq
#import "./assertions/string.typ": *

#let one-of(list) = (
  condition: (self, it)=>{
    list.contains(it)
  },
  message: (self, it)=> "Unknown " + self.name + " `" + repr(it) + "`"
)