#!/bin/bash
#On extrait la signature de la banque
cat cheque.txt | grep "signature banque:" -A 1 | tail -n 1 >> extract_signbank.txt
#On extrait le reste
cat cheque.txt |grep -B 4 "signature banque:" | head -n 4 >> extract_signedbank.txt
#On vérifie la partie chiffrée par la banque (id_client,client_pkey) avec la clé publique de la banque
openssl dgst -sha256 -verify bank_pkey.key -signature extract_signbank.txt extract_signedbank.txt

#On extrait la signature du client
cat cheque.txt | grep "signature du client:" -A 3 | tail -n 3 >> extract_signclient.txt

