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

let jump cert_files =
  let cert_files = List.map Fpath.v cert_files in
  let fps = List.map fp_of_cert_file cert_files in
  List.iter2
    (fun cert_file fp ->
       Fmt.pr "%a: %a\n" Fpath.pp cert_file Hex.pp (Hex.of_cstruct fp))
    cert_files
    fps

open Cmdliner

let certs =
  let doc = "PEM-encoded certificate file" in
  Arg.(value & pos_all non_dir_file [] & info ~docv:"CERT_FILE" ~doc [])

let cmd =
  let info =
    Cmd.info  "cert-pubkey-fp"
      ~version:"%%VERSION%%"
      ~doc:"Print public key fingerprints of certificates"
  in
  Cmd.v info Term.(const jump $ certs)

let () =
  exit @@
  Cmd.eval cmd
