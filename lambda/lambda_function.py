import os
import json

import boto3
from botocore.exceptions import ClientError

s3client = boto3.client('s3')
kendra = boto3.client('kendra')
teclient = boto3.client('textract')

import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

#Event handler for S3 bucket to update the kendra index with the document details for a newly uploaded document

def lambda_handler(event, context):
    logger.info("Received event: %s" % json.dumps(event))
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        key_split = key.split('/')
        key_len = len(key_split)
        doc_name = key_split[key_len-1]
        doc_type = key_split[1]

        if (doc_type == "user-guides"):
            acclist = [
                { "Access": "ALLOW", "Name": "customer", "Type": "GROUP" },
                { "Access": "ALLOW", "Name": "AWS-Sales", "Type": "GROUP" },
                { "Access": "ALLOW", "Name": "AWS-Marketing", "Type": "GROUP" },
                { "Access": "ALLOW", "Name": "AWS-SA", "Type": "GROUP" },
                ]
        elif (doc_type == "case-studies"):
            acclist = [
                { "Access": "ALLOW", "Name": "AWS-Sales", "Type": "GROUP" },
                { "Access": "ALLOW", "Name": "AWS-Marketing", "Type": "GROUP" },
                { "Access": "ALLOW", "Name": "AWS-SA", "Type": "GROUP" },
                ]
        elif (doc_type == "analyst-reports"):
            acclist = [
                { "Access": "ALLOW", "Name": "AWS-Marketing", "Type": "GROUP" },
                { "Access": "ALLOW", "Name": "AWS-SA", "Type": "GROUP" },
                ]
        elif (doc_type == "white-papers"):
            acclist = [
                { "Access": "ALLOW", "Name": "AWS-SA", "Type": "GROUP" },
                ]
        else:
            acclist = [
                { "Access": "ALLOW", "Name": "AWS-SA", "Type": "GROUP" },
                ]
        documents = [ 
            {
                "Id": doc_name,
                "Title": doc_name,
                "S3Path": {
                    "Bucket": bucket,
                    "Key": key
                },
                ## Simplistic logic to use the middle part of the prefix as the DocumentType
                "Attributes": [
                    {
                        "Key": "DocumentType",
                        "Value": {
                            "StringValue": doc_type
                        }
                    },
                    {
                        "Key": "_source_uri",
                        "Value": {
                            "StringValue": "https://s3.us-east-1.amazonaws.com/" + bucket + '/' + key
                        }
                    },
                    {
                        "AccessControlList": acclist
                    }
                ]
            }
        ]
        
        result = kendra.batch_put_document(
            IndexId = "10c7ac35-6c65-48f0-9c03-5bfcf58d288d",
            RoleArn = "arn:aws:iam::973830535680:role/AJKendraRoleForGettingStartedDataSource",
            Documents = documents
        )
        logger.info("kendra.batch_put_document: %s" % json.dumps(documents))
        logger.info("result: %s" % json.dumps(result))
