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

#let coerce-license(self, it) = {
  if ( it in ("CC0", "CC0-1.0")){
    return (
      id: "CC0-1.0",
      url: "https://creativecommons.org/licenses/zero/1.0/",
      name: "Creative Commons Zero v1.0 Universal",
    ) 
  } else if ( it in ("CC-BY", "CC-BY-4.0")){
    return (
      id: "CC-BY-4.0",
      url: "https://creativecommons.org/licenses/by/4.0/",
      name: "Creative Commons Attribution 4.0 International",
    )
  } else if ( it in ("CC-BY-NC", "CC-BY-NC-4.0")){
    return (
      id: "CC-BY-NC-4.0",
      url: "https://creativecommons.org/licenses/by-nc/4.0/",
      name: "Creative Commons Attribution Non Commercial 4.0 International"
    )
  } else if ( it in ("CC-BY-NC-SA", "CC-BY-NC-SA-4.0")){
    return (
      id: "CC-BY-NC-SA-4.0",
      url: "https://creativecommons.org/licenses/by-nc-sa/4.0/",
      name: "Creative Commons Attribution Non Commercial Share Alike 4.0 International",
    )
  } else if ( it in ("CC-BY-ND", "CC-BY-ND-4.0")){
    return (
      id: "CC-BY-ND-4.0",
      url: "https://creativecommons.org/licenses/by-nd/4.0/",
      name: "Creative Commons Attribution No Derivatives 4.0 International",
    )
  } else if ( it in ("CC-BY-NC-ND", "CC-BY-NC-ND-4.0")){
    return (
      id: "CC-BY-NC-ND-4.0",
      url: "https://creativecommons.org/licenses/by-nc-nd/4.0/",
      name: "Creative Commons Attribution Non Commercial No Derivatives 4.0 International",
    )
  }
}

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
    abstracts: z.array(abstracts, pre-transform: coerce.array),
    citation: z.optional(z.content()),
    open-access: z.optional(z.boolean()),
    venue: z.optional(z.content()),
    doi: z.optional(z.string()),
    keywords: z.array(z.string()),
    license: z.optional(z.dictionary(
      (
        id: z.string(),
        url: z.string(),
        name: z.string()
      ),
      pre-transform: coerce-license
    )),
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
  )
)