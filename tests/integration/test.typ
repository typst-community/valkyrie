#import "/src/lib.typ" as z
//#set page(height: 1cm, width: 1cm)

// todo(james): Could/should this be included in the library?
#let coerced-dictionary(
  from,
  transform: (it)=>it,
  ..args
) = z.either(
  z.dictionary(..args),
  from(transform: transform)
)

// todo(james): Could/should this be included in the library?
#let coerced-array(schema) = z.either(
  schema(transform: (it)=>(it,)),
  z.array(schema())
)

#let author-schema = coerced-dictionary(
  z.string,
  name: z.string(),
  transform: (it)=>(author: it),
  url: z.optional(z.string()),
  phone: z.optional(z.string()),
  fax: z.optional(z.string()),
  orcid: z.optional(z.string()),
  note: z.optional(z.string()),
  corresponding: z.boolean(default: false), // TO-DO check for email
  equal-contributor: z.optional(z.boolean()),
  roles: z.array(z.string()),
  affiliations: coerced-array(coerced-dictionary.with(
    z.string,
    id: z.string(),
    index: z.optional(z.number()),
    transform: (it)=>(id: it)
  ))
)

#let affiliation-schema = coerced-dictionary(
  z.string,
  id: z.optional(z.string()),
  index: z.optional(z.number()),
  name: z.string(),
  institution: z.optional(z.string()),
  transform: (it)=>{(name: it)}
)

#let affiliation-schema = coerced-dictionary(
  z.string,
  id: z.optional(z.string()),
  index: z.optional(z.number()),
  name: z.string(),
  institution: z.optional(z.string()),
  transform: (it)=>(name: it)
)

#let pubmatter-schema = z.dictionary(
  title: z.optional(z.content()),
  subtitle: z.optional(z.content()),
  short-title: z.optional(z.string()),
  authors: z.array(author-schema),
  affiliations: z.array(affiliation-schema),
  open-access: z.optional(z.boolean()),
  license: coerced-dictionary(
    z.string,
    id: z.optional(z.string()),
    url: z.optional(z.string()),
    name: z.string(),
    transform: (it)=>(name: it)
  ),
  doi: z.optional(z.string()),
  date: z.any(),// z.datetime() not implemented
  citation: z.optional(z.content()),
  abstracts: z.either(
    z.content(transform: (it)=>(
      title: "Abstract",
      content: it
    )),
    z.array(z.dictionary(
      title: z.optional(z.content()),
      content: z.content()
    ))
  )
);

//#pubmatter-schema

// Multiple pass?
#z.parse(z.parse(z.parse( (
  title: "pubmatter",
  subtitle: "A typst library for parsing, normalizing and showing publication frontmatter",
  authors: (
    (
      name: "Rowan Cockett",
      email: "rowan@curvenote.com",
      orcid: "0000-0002-7859-8394",
      github: "rowanc1",
      affiliations: ("Curvenote Inc.",),
    ),
  ),
  open-access: true,
  license: "CC-BY-4.0",), pubmatter-schema), pubmatter-schema), pubmatter-schema)


  #z.parse((
authors: (
    (
      name: "Rowan Cockett",
      affiliations: "Curvenote Inc.",
    ),
    (
      name: "Steve Purves",
      affiliations: ("Executable Books", "Curvenote Inc."),
    ),
  ),)
,pubmatter-schema)
