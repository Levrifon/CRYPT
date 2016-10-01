#!/bin/bash
echo "Generation de la facture : "
echo "id_marchand:" >> facture.txt
echo "marchand1" >> facture.txt
echo "montant:">> facture.txt
echo "55€" >> facture.txt
echo "id_facture:" >> facture.txt
echo $RANDOM >> facture.txt
#Envoi de la facture au client
mv facture.txt ../client/
echo "Facture envoyée"

