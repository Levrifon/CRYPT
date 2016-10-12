#!/bin/bash
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
echo '' >> client_info.txt
#Signature des infos du client par la banque
signature_banque=`openssl dgst -sha256 -sign bank_skey.key client_info.txt | base64 | tr -d '\n'`
cp client_info.txt client_info_sauvegarde.txt
echo "signature banque:" >> client_info.txt
echo $signature_banque >> client_info.txt
echo $signature_banque >> sauvegarde_sign_bank.txt
#echo -e '\n' >> client_info.txt
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
cp cheque.txt ../client/
echo "Terminé"


