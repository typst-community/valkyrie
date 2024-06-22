#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{
  let test-tuple = (
    "123",
    "email@address.co.uk",
    1.1
    )

  z.parse(
    test-tuple,
    z.tuple(
      z.string(),
      z.email(),
      z.floating-point(),
    ),
  )
}
