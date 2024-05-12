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
    url: z.string(optional: true),
    phone: z.string(optional: true),
    fax: z.string(optional: true),
    orcid: z.string(optional: true),
    note: z.string(optional: true),
    email: z.email(optional: true),
    corresponding: z.boolean(optional: true),
    equal-contributor: z.boolean(optional: true),
    deceased: z.boolean(optional: true),
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
    if (it.at("email", default: none) != none and it.corresponding == none){
      it.insert("corresponding", true)
    }
    return it;
  }
)

#let affiliation = z.dictionary(
  (
    id: z.string(optional: true),
    index: z.number(optional: true),
    name: z.string(optional: true),
    institution: z.string(optional: true)
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
    title: z.content(optional: true),
    subtitle: z.content(optional: true),
    short-title: z.string(optional: true),
    authors: z.array(author, pre-transform: coerce.array),
    affiliations: z.array(affiliation, pre-transform: coerce.array),
    abstracts: z.array(abstracts, pre-transform: coerce.array),
    citation: z.content(optional: true),
    open-access: z.boolean(optional: true),
    venue: z.content(optional: true),
    doi: z.string(optional: true),
    keywords: z.array(z.string()),
    license: z.dictionary(
      optional: true,
      (
        id: z.string(),
        url: z.string(),
        name: z.string()
      ),
      pre-transform: coerce-license
    ),
    dates: z.array(
      z.dictionary(
        (
          type: z.content(optional: true),
          date: z.date(pre-transform: coerce.date)
        ),
        pre-transform: coerce.dictionary((it)=>(date: it))
      ),
      pre-transform: coerce.array
    ),
  )
)