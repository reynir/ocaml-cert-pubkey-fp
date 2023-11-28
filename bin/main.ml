let fp_of_cert_file cert_file =
  let pem =
    match Bos.OS.File.read cert_file with
    | Ok pem -> pem
    | Error `Msg e ->
      Fmt.epr "Failed to read %a: %s\n" Fpath.pp cert_file e;
      exit 1
  in
  let cert =
    match X509.Certificate.decode_pem (Cstruct.of_string pem) with
    | Ok cert -> cert
    | Error `Msg e ->
      Fmt.epr "Failed to decode certificate %a: %s\n" Fpath.pp cert_file e;
      exit 1
  in
  let pubkey = X509.Certificate.public_key cert in
  X509.Public_key.fingerprint pubkey

let jump colonize cert_files =
  let cert_files = List.map Fpath.v cert_files in
  let fps = List.map fp_of_cert_file cert_files in
  let pp_hex =
    if not colonize then
      Hex.pp
    else
      fun ppf (`Hex hex) ->
        if String.length hex >= 2 then
          Fmt.pf ppf "%c%c" hex.[0] hex.[1];
        for i = 1 to (String.length hex - 1) / 2 do
          Fmt.pf ppf ":%c%c" hex.[2*i] hex.[2*i+1]
        done
  in
  List.iter2
    (fun cert_file fp ->
       Fmt.pr "%a: %a\n" Fpath.pp cert_file pp_hex (Hex.of_cstruct fp))
    cert_files
    fps

open Cmdliner

let certs =
  let doc = "PEM-encoded certificate file." in
  Arg.(value & pos_all non_dir_file [] & info ~docv:"CERT_FILE" ~doc [])

let colonize =
  let doc = "Add a bunch of colons in the output." in
  Arg.(value & flag & info ~doc ~docs:"NON-COLONIAL OPTIONS" [ "colonize" ])

let cmd =
  let info =
    Cmd.info  "cert-pubkey-fp"
      ~version:"%%VERSION%%"
      ~doc:"Print public key fingerprints of certificates"
  in
  Cmd.v info Term.(const jump $ colonize $ certs)

let () =
  exit @@
  Cmd.eval cmd
