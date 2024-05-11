#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  _ = z.parse("1.1.1.1", z.optional(z.ip()))
  _ = z.parse(none, z.optional(z.ip()))
  //_ = z.parse("not an ip", z.optional(z.ip()))
}
