#import "/src/lib.typ" as z
#set page(height: auto, paper: "a6")

= Array Tests

#z.parse( ("hello@world.ac.uk", "not an email"), z.array())

#z.parse( ("hello@world.ac.uk", "not an email"), z.array(z.email(), min: 1))

// #z.parse( (), z.array(z.string(), default: (0,)))