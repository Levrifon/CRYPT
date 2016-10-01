#!/bin/bash
echo "Remplissage du cheque"
cat client_info.txt >> cheque.txt
echo "montant:" >> cheque.txt
cat facture.txt | grep '€' >> cheque.txt
cat facture.txt | grep 'id_marchand' -A 1 >> cheque.txt
echo "id_cheque:"
echo $RANDOM >> cheque.txt
echo "Envoi de la clé publique du client au marchand:"
cp client_pkey.key ../marchand/
echo "Envoi terminé"
echo "signature du client:" >> cheque.txt
openssl dgst -sha256 -sign client_skey.key cheque.txt |base64 >> cheque.txt
mv cheque.txt ../marchand/

