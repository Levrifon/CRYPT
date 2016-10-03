#!/bin/bash
#backup du cheque vierge
#cp cheque_description.txt cheque_vierge.txt
#La banque créer son couple bank_skey/bank_pkey
openssl genrsa 1024 > bank_skey.key
cat bank_skey.key | openssl rsa -pubout > bank_pkey.key
#La banque créer le couple client_skey|client_pkey
openssl genrsa 1024 > client_skey.key
cat client_skey.key | openssl rsa -pubout > client_pkey.key
#La banque créer les infos du client
echo "id_client:" >> client_info.txt
echo "id_client1" >> client_info.txt
echo "client_pkey:" >> client_info.txt
cat client_pkey.key | tr -d '\n' >> client_info.txt
#Signature des infos du client par la banque
signature_banque=`openssl dgst -sha256 -sign bank_skey.key client_info.txt | base64 | tr -d '\n'`
echo -e '\n' >> client_info.txt
echo "signature banque:" >> client_info.txt
echo $signature_banque >> client_info.txt
echo -e '\n' >> client_info.txt
#La banque envoie les infos au client
cp client_info.txt ../client/
#La banque envoie le couple client_skey/client_pkey 
cp client_pkey.key ../client/
cp client_skey.key ../client/
#La banque distribue sa clé publique au marchand et au client
cp bank_pkey.key ../client/
cp bank_pkey.key ../marchand/
#La banque envoie un chèque vierge au client
touch cheque.txt
mv cheque.txt ../client/

#openssl dgst -sha256 cheque_description.txt > bank_hash
#openssl rsautl -sign -inkey bank_skey.key -keyform PEM -in bank_hash > bank_signature
#cp bank_pkey.key ../client/
#cp bank_pkey.key ../marchand/
#echo "Fin de la génération"
#echo "Generation cle publique/privee du client.."
#openssl genrsa 1024 > ../client/client_skey.key
#cat ../client/client_skey.key | openssl rsa -pubout > ../client/client_pkey.key
#echo "Generation signature"
#echo "Signature de la banque : " >> cheque_description.txt
#cat bank_signature | base64 >> cheque_description.txt
#echo "Generation du cheque"
#cp cheque_description.txt ../client/
echo "Terminé"


