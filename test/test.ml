(* This test reads the file "esope.odt", replaces the token USER by the current
   user, saves the resulting file, and checks it by asking libreoffice to
   convert the result to a txt file. *)

(* TODO: if libreoffice is not found, look for openoffice, or ... *)

let make_file user =
  let outfile = "esope_user.odt" in
  print_endline ("Creating file: " ^ (Filename.concat (Sys.getcwd ()) outfile));
  let f = Odt.load "esope.odt" in
  let ff = Odt.replace_token ~token:"USER" user f in
  Odt.save outfile ff;
  print_endline "File saved."

let check_file user =
  print_endline "Checking file...";
  if Sys.command "libreoffice --convert-to txt esope_user.odt" <> 0
  then failwith "Could not convert to test"
  else
    let inch = open_in "esope_user.txt" in
    let s = "Cette version est dédicacée au sot " ^ user ^ "." in
    let rec loop () =
      let l = input_line inch in
      if l = s then () else loop () in
    try loop (); print_endline "Good!" with
    | End_of_file -> failwith "Could not find modified line."

let () =
  let user = Sys.getenv "HOME" |> Filename.basename |> String.capitalize_ascii in
  make_file user;
  check_file user
