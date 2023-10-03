# cert-pubkey-fp

Do you occasionally need the public key fingerprint of a certificate?
Do you also struggle remembering `openssl x509 -noout -pubkey | openssl pkey -pubin -outform DER | openssl dgst -SHA256`??
Have you made the mistake thinking `openssl x509 -noout -fingerprint` would print the public key fingerprint?!? Then `cert-pubkey-fp` is for you!

The command line tool `cert-pubkey-fp` takes as argument a list of PEM-encoded certificate files and prints out their public key fingerprints:

```
$ cert-pubkey-fp *.crt
ca.crt: c13701b99e434447b239db7bab426dc303580bcbd9a5771ddfdfd5cdd3b9fabb
client.crt: 6c3cb3b3988354351de2d65faab4bc61ee2ed69692bd34addfcd533a4ab33809
server.crt: 554ef40554bf08b7c85d46413b70b32ef43424bb41838a987f72fb785aafbfb4
$ # wow, so easy!
```
