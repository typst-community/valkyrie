#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  _ = z.parse(rgb(0,0,0), z.color())
  _ = z.parse(cmyk(0%,0%,0%,0%), z.color())
  //_ = z.parse(0, z.color())
  //_ = z.parse(none, z.color())
}
