#!/bin/bash
openssl genrsa 1024 > bank_skey.key
cat bank_skey.key | openssl rsa -pubout > bank_pkey.key
openssl dgst -sha256 cheque_description.txt > bank_hash
openssl rsautl -sign -inkey bank_skey.key -keyform PEM -in bank_hash > bank_signature
cp bank_pkey.key ../client/
cp bank_pkey.key ../marchand/
echo "Fin de la génération"
echo "Generation cle publique/privee du client.."
openssl genrsa 1024 > ../client/client_skey.key
cat ../client/client_skey.key | openssl rsa -pubout > ../client/client_pkey.key
echo "Generation signature"
echo "Signature de la banque : " >> cheque_description.txt
cat bank_signature | base64 >> cheque_description.txt
echo "Generation du cheque"
cp cheque_description.txt ../client/
echo "Terminé"


