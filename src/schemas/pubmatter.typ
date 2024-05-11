#import "/src/types.typ" as z;
#import "/src/coercions.typ" as coerce;

#let author = z.dictionary(
  aliases: (
    "affiliation":"affiliations",
    "website": "url",
    "homepage": "url",
    "ORCID": "orcid",
    "equal_contributor": "equal-contributor",
    "equalContributor": "equal-contributor",
  ),
  (
    name: z.string(),
    url: z.optional(z.string()),
    phone: z.optional(z.string()),
    fax: z.optional(z.string()),
    orcid: z.optional(z.string()),
    note: z.optional(z.string()),
    email: z.optional(z.email()),
    corresponding: z.optional(z.boolean()),
    equal-contributor: z.optional(z.boolean()),
    deceased: z.optional(z.boolean()),
    roles: z.array(z.string(), pre-transform: coerce.array),
    affiliations: z.array(
      z.either(
        z.string(),
        z.number()
      ),
      pre-transform: coerce.array
    )
  ),
  pre-transform: coerce.dictionary((it)=>(name: it)),
  post-transform: (self, it)=>{
    if (it.at("email") != none and it.corresponding == none){
      it.insert("corresponding", true)
    }
    return it;
  }
)

#let affiliation = z.dictionary(
  (
    id: z.optional(z.string()),
    index: z.optional(z.number()),
    name: z.optional(z.string()),
    institution: z.optional(z.string())
  ),
  pre-transform: coerce.dictionary((it)=>(name: it))
)

#let abstracts = z.dictionary(
  (
    title: z.string(default: "Abstract"),
    content: z.content(),
  ),
  pre-transform: coerce.dictionary(it=>(content: it))
)

#let pubmatter = z.dictionary(
  aliases: (
    "author": "authors",
    "running-title": "short-title",
    "running-head": "short-title",
    "affiliation": "affiliations",
    "abstract": "abstracts",
    "date": "dates"
  ),
  (
    title: z.optional(z.content()),
    subtitle: z.optional(z.content()),
    short-title: z.optional(z.string()),

    authors: z.array(author, pre-transform: coerce.array),
    affiliations: z.array(affiliation, pre-transform: coerce.array),

    open-access: z.optional(z.boolean()),
    venue: z.optional(z.content()),
    license: z.optional(z.dictionary(
      (
        id: z.optional(z.string()),
        url: z.optional(z.string()),
        name: z.optional(z.string())
      ), default: none)
    ),

    doi: z.optional(z.string()),
    keywords: z.array(z.string()),
    dates: z.array(
      z.dictionary(
        (
          type: z.optional(z.content()),
          date: z.date(pre-transform: coerce.date)
        ),
        pre-transform: coerce.dictionary((it)=>(date: it))
      ),
      pre-transform: coerce.array
    ),
    citation: z.optional(z.content()),

    abstracts: z.array(abstracts, pre-transform: coerce.array)
  )
)