#!/bin/bash

aws kendra query --index-id "10c7ac35-6c65-48f0-9c03-5bfcf58d288d" \
    --query-text "five pillars" \
    --attribute-filter '{"EqualsTo": {"Key": "DocumentType","Value": {"StringValue": "White Paper"}}}'