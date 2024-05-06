#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  _ = z.parse(true, z.boolean())
  _ = z.parse(false, z.boolean())
  //_ = z.parse(0, z.boolean())
  //_ = z.parse(none, z.boolean())
}
