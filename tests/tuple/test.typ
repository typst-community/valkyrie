#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  let test-tuple = ("String", "email@address.co.uk", 1.1)

  _ = z.parse(test-tuple, z.tuple(
    z.string(),
    z.email(),
    z.floating-point()
  ))
}
