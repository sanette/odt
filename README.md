# odt
search/replace in odt (OpenDocument Text) files

This Ocaml "library" is actually just a dirty hack that does only one
thing: search/replace tokens in odt files. Useful for mailing for
instance, when you want to replace the token |NAME| by names from a
list, etc.

It works for me, and I use in at work, but there is **no** guarantee
whatsoever that it works on every odt file out there. Always keep a
copy of the orignial file, of course!

# install

clone the git repository, then:
```
cd odt
dune build
dune runtest
opam install .
```

(The `runtest` assumes you have `libreoffice` in your path. If not,
just disregard the test.)

# usage

See `test/test.ml`
