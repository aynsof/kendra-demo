#!/bin/bash

#Simple query with an optional parameter for document type

if [ $# -eq 1 ]
then
    aws kendra query --index-id "10c7ac35-6c65-48f0-9c03-5bfcf58d288d" --query-text "$1"
elif [ $# -eq 2 ]
then
    aws kendra query --index-id "10c7ac35-6c65-48f0-9c03-5bfcf58d288d" --query-text "$1" \
        --attribute-filter '{"EqualsTo": {"Key": "DocumentType","Value": {"StringValue": "'"$2"'"}}}'
else
    echo "usage $0 <query> [document type]" >&2
    exit 1
fi