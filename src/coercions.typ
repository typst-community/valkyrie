
///
#let dictionary(fn) = (self, it) => {
  if (type(it) != type((:))) {
    return fn(it)
  }
  it
}

///
#let array(self, it) = {
  if (type(it) != type(())) {
    return (it,)
  }
  it
}

///
#let content(self, it) = [#it]

///
#let date(self, it) = {
  if (type(it) == type(datetime.today())) {
    return it
  }
  if (type(it) == int) {
    // assume this is the year
    assert(it > 1000 and it < 3000, message: "The date is assumed to be a year between 1000 and 3000")
    return datetime(year: it, month: 1, day: 1)
  }

  if (type(it) == str) {
    let yearMatch = it.find(regex(`^([1|2])([0-9]{3})$`.text))
    if (yearMatch != none) {
      // This isn't awesome, but probably fine
      return datetime(year: int(it), month: 1, day: 1)
    }
    let dateMatch = it.find(regex(`^([1|2])([0-9]{3})([-\/])([0-9]{1,2})([-\/])([0-9]{1,2})$`.text))
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

  if (type(it) == dictionary) {
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