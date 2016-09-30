#!/bin/bash
cat cheque.txt | grep "signature banque:" -A 3 | tail -n 3
