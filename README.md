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

It does nothing else!
(Besides printing `--help` or `--version` information if requested)

## Non-colonial options

**new**: `cert-pubkey-fp` now supports the `--colonize` option!
This flag adds a colon in between every pair of hex digits like so:

```
$ cert-pubkey-fp --colonize *.crt
ca.crt: c1:37:01:b9:9e:43:44:47:b2:39:db:7b:ab:42:6d:c3:03:58:0b:cb:d9:a5:77:1d:df:df:d5:cd:d3:b9:fa:bb
client.crt: 6c:3c:b3:b3:98:83:54:35:1d:e2:d6:5f:aa:b4:bc:61:ee:2e:d6:96:92:bd:34:ad:df:cd:53:3a:4a:b3:38:09
server.crt: 55:4e:f4:05:54:bf:08:b7:c8:5d:46:41:3b:70:b3:2e:f4:34:24:bb:41:83:8a:98:7f:72:fb:78:5a:af:bf:b4
$ # wow, so verbose!
```
