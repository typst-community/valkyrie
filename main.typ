#import "src/lib.typ" as z

#let signature = z.object(
  title: z.string(min: 70),
  authors: z.array(
    z.object(
      name: z.string()
    )
  )
)

#let main( body, title: none, authors: none) = {
  let title = z.parse(title, z.string(min: 10))

  title
  body
}

#show: main.with(
  title: "Hello World",
  authors: (
    (
      name: "John Doe",
      
    ),
  )
)

Hello World132