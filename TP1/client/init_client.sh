#!/bin/bash
echo "Remplissage du cheque"
cat client_info.txt >> cheque.txt
#on rajoute l'id_marchand
cat facture.txt | grep 'id_marchand' -A 1 >> cheque.txt
#on rajoute le montant
echo "montant:" >> cheque.txt
cat facture.txt | grep '€' >> cheque.txt
#on rajoute l'id_facture
cat facture.txt | grep 'id_facture' -A 1 >>cheque.txt
#on rajoute un id_cheque
echo "id_cheque:" >> cheque.txt
echo $RANDOM >> cheque.txt
echo "Envoi de la clé publique du client au marchand:"
cp client_pkey.key ../marchand/
echo "Envoi terminé"
cp cheque.txt cheque_sauvegarde.txt
signature_client=`openssl dgst -sha256 -sign client_skey.key cheque.txt | base64 | tr -d '\n'`
echo "signature du client:" >> cheque.txt
echo $signature_client >> cheque.txt
echo '' >> cheque.txt
cp cheque.txt ../marchand/

