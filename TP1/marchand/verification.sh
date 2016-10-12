#!/bin/bash
#On extrait la signature de la banque
cat cheque.txt | grep "signature banque:" -A 1 | tail -n 1 | base64 -d >> extract_signbank.txt
#On extrait le reste
cat cheque.txt |grep -B 4 "signature banque:" | head -n 4 >> extract_signedbank.txt
#On vérifie la partie signée par la banque (id_client,client_pkey) avec la clé publique de la banque
echo "Verification signature de la banque :"
openssl dgst -sha256 -verify bank_pkey.key -signature extract_signbank.txt extract_signedbank.txt

#On extrait la signature du client
cat cheque.txt | grep "signature du client:" -A 1 | tail -n 1 | base64 -d >> extract_signclient.txt
#On extrait le reste
cat cheque.txt | grep "signature du client:" -B 14 | head -n 14 >> extract_signedclient.txt
#On vérifie la partie signée par le client (id_client,client_pkey,signature_bank,montant,id_marchand,aleat)
echo "Verification signature du client :"
openssl dgst -sha256 -verify client_pkey.key -signature extract_signclient.txt extract_signedclient.txt
echo "Verification du montant :" 
montant_marchand=$(cat facture.txt | grep -A 1 "montant" | tail -n 1)
montant_client=$(cat ../client/cheque.txt | grep -A 1 "montant" | tail -n 1)
if [ "$montant_marchand" == "$montant_client" ]
then
	echo "Montant OK"
fi
echo "Transmission du chèque à la banque :"
cp cheque.txt ../banque/

