#!/bin/bash
cd banque/
echo "Nettoyage banque en cours.."
rm *.key
rm *.txt
echo "OK"
cd ../client/
echo "Nettoyage client en cours.."
rm *.key
rm *.txt
echo "OK"
cd ../marchand/
echo "Nettoyage marchand en cours.."
rm *.key
rm *.txt
