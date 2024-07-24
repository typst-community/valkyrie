#import "/src/lib.typ" as z
#set page(height: auto, width: auto)

#let test(x) = z.parse(x, z.version(pre-transform: z.coerce.version))

#repr(test(1))

#repr(test((1,1)))

#repr(test("1.1."))

#repr(test("1.0.1.0"))


