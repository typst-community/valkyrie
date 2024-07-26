/// An attempt is made to convert string, numeric, or dictionary inputs into datetime objects
///
/// #example[```
/// #let schema = z.date(
///   pre-transform: z.coerce.date
/// )
///
/// #z.parse(2020, schema) \
/// #z.parse("2020-03-15", schema) \
/// #z.parse("2020/03/15", schema) \
/// #z.parse((year: 2020, month: 3, day: 15), schema) \
/// ```]
#let date(self, it) = {
  if (type(it) == datetime) {
    return it
  }
  if (type(it) == int) {
    // assume this is the year
    assert(
      it > 1000 and it < 3000,
      message: "The date is assumed to be a year between 1000 and 3000",
    )
    return datetime(year: it, month: 1, day: 1)
  }

  if (type(it) == str) {
    let yearMatch = it.find(regex(`^([1|2])([0-9]{3})$`.text))
    if (yearMatch != none) {
      // This isn't awesome, but probably fine
      return datetime(year: int(it), month: 1, day: 1)
    }
    let dateMatch = it.find(
      regex(`^([1|2])([0-9]{3})([-\/])([0-9]{1,2})([-\/])([0-9]{1,2})$`.text),
    )
    if (dateMatch != none) {
      let parts = it.split(regex("[-\/]"))
      return datetime(
        year: int(parts.at(0)),
        month: int(parts.at(1)),
        day: int(parts.at(2)),
      )
    }
    panic("Unknown datetime object from string, try: `2020/03/15` as YYYY/MM/DD, also accepts `2020-03-15`")
  }

  if (type(it) == type((:))) {
    if ("year" in it) {
      return return datetime(
        year: it.at("year"),
        month: it.at("month", default: 1),
        day: it.at("day", default: 1),
      )
    }
    panic("Unknown datetime object from dictionary, try: `(year: 2022, month: 2, day: 3)`")
  }
  panic("Unknown date of type '" + type(it) + "' accepts: datetime, str, int, and object")

}