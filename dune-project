(lang dune 3.10)

(name cert-pubkey-fp)

(generate_opam_files true)

(source
 (github reynir/ocaml-cert-pubkey-fp))

(authors "Reynir Björnsson <reynir@reynir.dk>")

(maintainers "Reynir Björnsson <reynir@reynir.dk>")

(license ISC)

(package
 (name cert-pubkey-fp)
 (synopsis "A commandline tool to print public key fingerprints of certificates")
 (description "This is an alternative to piping openssl x509 -pubkey through all sorts of commands just to get the public key fingerprint.")
 (depends ocaml dune x509 hex bos cmdliner))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
