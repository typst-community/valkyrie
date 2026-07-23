
#let package = toml("/typst.toml").package

#import "@preview/hitec:0.1.0"
#let (
  // Metadata
  title,
  author,
  company,
  confidential,
  date,
  double-sided,
  print,
  // Layouts
  doc,
  title-page,
  title-block,
) = hitec.documentclass(
  title: [Valkyrie Package Documentation, version #package.version],
  author: package.authors,
  company: [Typst Community],
  // confidential: [#sym.bar.h Unlimited Distribution #sym.bar.h],
  date: datetime.today(),
  double-sided: true, // Enable double-sided printing
  print: false, // Add margins to binding side for printing
)

#let rule(doc) = {
  set heading(numbering: "1.")
  set par(first-line-indent: 0em, justify: true)

  title-block()
  pagebreak()

  outline()
  pagebreak()

  doc
}