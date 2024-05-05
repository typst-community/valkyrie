#import "/src/lib.typ" as z
//#set page(height: 1cm, width: 1cm)

#{
  let test = z.dictionary(
    title: z.content(),
    paper: z.papersize(default: "a4"),
    authors: z.array(z.dictionary(
      name: z.string(),
      corresponding: z.boolean(default: false),
      orcid: z.optional(z.string())
    )),
    header: z.dictionary(
      article-type: z.string(default: "Article"),
      article-color: z.color(default: rgb(87, 127, 230)),
      article-meta: z.content(default: [])
    ),
    keywords: z.array(z.string())
  );


  z.parse((
    title: [],
    authors: (
      (
        name: "James",
      ),(
        name: "Jim",
        corresponding: true
      ),
    ),
    header: (article-color: cmyk(27%, 0%, 3%, 5%),)
  ), test);

}