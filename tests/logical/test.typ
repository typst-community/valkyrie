#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  _ = z.parse("1.1.1.1", z.either(z.email(), z.ip()))
  _ = z.parse("test@hello.wor.ld", z.either(z.email(), z.ip()))
}
