#import "/src/lib.typ" as z
#set page(height: 1cm, width: 1cm)

#{

  let strict-context = z.z-ctx(strict: true)

  let test-dictionary = (
    //string: "world",
    // number: 1.2,
    email: "hello@world.com",
    ip: "1.1.251.1",
  )

  _ = z.parse(test-dictionary, z.dictionary(
    email: z.email(),
    ip: z.ip(),
  ), ctx: strict-context)
}
