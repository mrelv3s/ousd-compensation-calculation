#!/bin/bash
###################################################################
# This is the motherscript that runs all the others to generate a
# complete dataset.
# 
# ./run.sh 11297907 data/ metadata/unique_addresses.txt http://eth-mainnet.alchemyapi.io/v1/asdf1234
###################################################################

BLOCK_START="11272254"
BLOCK_END="$1"
OUT_DIR="$2"
ADDRESS_LIST="$3"
JSONRPC_ENDPOINT="$4"

###
# Extract
###
./extract.sh $BLOCK_END $OUT_DIR $ADDRESS_LIST $JSONRPC_ENDPOINT

###
# Transform
###

python transform.py -o $OUT_DIR -s $BLOCK_START -e $BLOCK_END -b metadata/blacklisted.txt > $OUT_DIR/reimbursements.csv

###
# Load
###

# ./load.sh