# [unreleased](https://github.com/jamesxX/valakyrie/releases/tags/)
## Added
- `Boolean` validation type
- `Content` validation type. Also accepts strings which are coerced into content types.
- `Color` validation type.
- `Optional` validation type. If a schema yields a validation error, the error is suppressed and the returned value is 'auto'
- `Choice` validation type. Tested value must be contained within the listed choices.
## Removed

## Changed
- fixed error in documentation for string type (previously read that it worked on numbers)
- Dictionaries that don't have a member that is present in the schema no longer produce an error outside of strict contexts.
- **(Potentially breaking)** Dictionaries default to empty dictionaries rather than none 
---

# [v0.1.1](https://github.com/jamesxX/valakyrie/releases/tags/v0.1.1)
## Changed
- fixed syntax error in Typst 0.11+ because of internal context type

---

# [v0.1.0](https://github.com/jamesxX/valakyrie/releases/tags/v0.1.0)
Initial Release
