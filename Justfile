root := justfile_directory()

export TYPST_ROOT := root
# export TYPST_FONT_PATHS := root / 'assets' / 'fonts'

[private]
default:
	@just --list --unsorted

# generate manual
doc:
	typst compile docs/manual.typ docs/manual.pdf

# run test suite
test *args:
	typst-test run {{ args }}

# update test cases
update *args:
	typst-test run {{ args }}

# run ci suite
ci: test doc
