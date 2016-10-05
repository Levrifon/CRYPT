#!/bin/bash
cd banque/
./init_bank.sh
cd ../marchand/
./facture.sh
cd ../client/
./init_client.sh
cd ../marchand/
./verification.sh
