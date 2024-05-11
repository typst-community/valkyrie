#import "/src/lib.typ" as z
//#set page(height: 1cm, width: 1cm)

#let test-schema = z.dictionary((
    id: z.optional(z.string()),
    index: z.optional(z.number()),
    name: z.string(),
    institution: z.optional(z.string()),
))

#let test-dictionary = (
    name: "Helsdflo",
    id: none,
  )

#z.parse(test-dictionary, test-schema , ctx: z.z-ctx(remove-optional-none: false))

  

#z.parse(test-dictionary, test-schema , ctx: z.z-ctx(remove-optional-none: true))
