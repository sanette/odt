(* Lecture/écriture d'un fichier odt simple *)

let datafile = "content.xml"

type t = { zfile : Zip.in_file; data : string }

let load file =
  let z = Zip.open_in file in
  let e = Zip.find_entry z datafile in
  {zfile = z; data = Zip.read_entry z e}

let replace_token ?(brackets=("|", "|")) ~token s f =
  let lb,rb = brackets in
  let r = Str.regexp_string (lb ^ token ^ rb) in
  { f with data = Str.global_replace r s f.data }

let save file f =
  let z = f.zfile in
  let out = Zip.open_out file in
  Zip.entries f.zfile
  |> List.iter (fun entry ->
      let data = if entry.Zip.filename = datafile
        then f.data
        else Zip.(find_entry z entry.filename)
             |> Zip.read_entry z in
      Zip.add_entry data out entry.Zip.filename);
  Zip.close_out out

(*

Pour compiler:
cd ..; dune build

ou bien:
ocamlfind ocamlc -package camlzip,str -c -annot -bin-annot odt.ml
ocamlfind ocamlc -a -o odt.cma odt.cmo
ocamlfind ocamlopt -package camlzip,str -c odt.ml
ocamlfind ocamlopt -a -o odt.cmxa odt.cmx

*)
