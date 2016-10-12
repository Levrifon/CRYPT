#!/bin/bash
touch transaction.txt
echo "Encaissement et vérification en cours .."
#On extrait la signature de la banque
cat cheque.txt | grep "signature banque:" -A 1 |tail -n 1 | base64 -d >> extract_signbank.txt
#On extrait le reste
cat cheque.txt |grep -B 4 "signature banque:" |head -n 4 >> extract_signedbank.txt
#On vérifie la partie signée par la banque (id_client,client_pkey) avec la clé publique de la banque
echo "Verification signature de la banque :"
openssl dgst -sha256 -verify bank_pkey.key -signature extract_signbank.txt extract_signedbank.txt

#On extrait la signature du client
cat cheque.txt |grep "signature du client:" -A 1 |tail -n 1 |base64 -d >> extract_signclient.txt
#On extrait le reste
cat cheque.txt |grep "signature du client:" -B 14 |head -n 14 >> extract_signedclient.txt
echo "Verification signature du client :"
openssl dgst -sha256 -verify client_pkey.key -signature extract_signclient.txt extract_signedclient.txt
#On enregistre le tout dans les historiques
id_client=$(cat cheque.txt |grep "id_client:" -A 1 |tail -n 1)
id_marchand=$(cat cheque.txt |grep "id_marchand:" -A 1 |tail -n 1)
id_facture=$(cat cheque.txt |grep "id_facture:" -A 1 |tail -n 1)
montant=$(cat cheque.txt |grep "montant:" -A 1 | tail -n 1)
#Verification existence de la transaction :
result=$(cat transaction.txt | grep -c "$id_client;$id_marchand;$id_facture")
if [ $result == 1 ] 
then
	echo "Transaction déjà existante"
	exit
else
	echo "Transaction nouvelle OK"
	echo "$id_client;$id_marchand;$id_facture;$montant" >> transaction.txt
fi
