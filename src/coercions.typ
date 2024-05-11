
#let dictionary(fn) = (self, it) => {
  if (type(it) != type((:))){
    return fn(it)
  }
  it
} 

#let array(self, it) = {
  if (type(it) != type(())){return (it,)}
  it
}

#let content(self, it)=[#it]

#let datetime(self, it)={
  
}