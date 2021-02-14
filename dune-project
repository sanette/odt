(lang dune 1.11)
(name odt)
(version "0.01")
(generate_opam_files true)
(license GPL3)
(maintainers "Vu Ngoc San <san.vu-ngoc@laposte.net>")
(authors "Vu Ngoc San <san.vu-ngoc@laposte.net>")
(source (github sanette/odt))

(package
 (name odt)
 (synopsis "Search/replace in ODT files")
 (depends
  (camlzip (>= 1.10))
))
