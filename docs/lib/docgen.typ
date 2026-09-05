
#let import-descriptor(path, namespace) = (path: path, namespace: namespace)

#let parse-source-imports(contents) = {

}

#let entrypoint(path) = {
  let contents = read(path)
  let imports = parse-source-imports(contents)

  return contents
}
