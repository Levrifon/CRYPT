#!/bin/bash
#On extrait la signature de la banque
cat cheque.txt | grep "signature banque:" -A 3 | tail -n 3 |base64 -d >> extract_signbank.txt
#On extrait la signature du client
cat cheque.txt | grep "signature du client:" -A 3 | tail -n 3 |base64 -d >> extract_signclient.txt

