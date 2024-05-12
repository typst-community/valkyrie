#import "/src/lib.typ" as z
//#set page(height: 1cm, width: 1cm)

#let test-schema = z.dictionary((
    id: z.string(optional: true),
    index: z.string(optional: true),
    name: z.string(),
    institution: z.string(optional: true),
))

#let test-dictionary = (
  name: "Helsdflo",
  id: none,
)

#z.parse(test-dictionary, test-schema , ctx: z.z-ctx(remove-optional-none: false))

  

#z.parse(test-dictionary, test-schema , ctx: z.z-ctx(remove-optional-none: true))
