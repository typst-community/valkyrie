#import "/src/lib.typ" as z
//#set page(height: 1cm, width: 1cm)

#{
  let test = z.dictionary(
    title: z.content(),
    authors: z.array(z.dictionary(
      name: z.string(),
      corresponding: z.boolean(default: false),
      orcid: z.optional(z.string())
    ))
  );


  z.parse((
    title: [],
    authors: ((
      name: "James",
      //corresponding: none,
      //orcid: ""
    ),)
  ), test);

}
sdf