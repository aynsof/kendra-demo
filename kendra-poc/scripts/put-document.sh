#/bin/bash

if [ $# -eq 1 ]
then
    ATTRIBUTES='"Attributes": [
                    {
                        "Key": "_source_uri",
                        "Value": {
                            "StringValue": "'"https://s3.us-east-1.amazonaws.com/t1-kendra-poc-001/Data/$1"'"
                        }
                    }
                ]'
    ACCESSCTRLLIST=""
elif [ $# -eq 2 ]
then
    ATTRIBUTES='"Attributes": [
                    {
                        "Key": "DocumentType",
                        "Value": {
                            "StringValue": "'"$2"'"
                        }
                    },
                    {
                        "Key": "_source_uri",
                        "Value": {
                            "StringValue": "'"https://s3.us-east-1.amazonaws.com/t1-kendra-poc-001/Data/$1"'"
                        }
                    }
                ]'
    ACCESSCTRLLIST=""
elif [ $# -eq 3 ]
then
    ATTRIBUTES='"Attributes": [
                    {
                        "Key": "DocumentType",
                        "Value": {
                            "StringValue": "'"$2"'"
                        }
                    },
                    {
                        "Key": "_source_uri",
                        "Value": {
                            "StringValue": "'"https://s3.us-east-1.amazonaws.com/t1-kendra-poc-001/Data/$1"'"
                        }
                    }
                ]'
    ACCESSCTRLLIST='"AccessControlList": '"$3"
else
    echo "usage $0 <Document Name> [DocumentType] [[ { Access: ALLOW | DENY, Name: 'STRING_VALUE', Type: USER | GROUP }]]" >&2
    exit 1
fi

if [ ! -f $1 ]
then
    echo "Document $1 does not exist" >&2
    exit 1
fi

aws s3 cp "$1" "s3://t1-kendra-poc-001/Data/$1"

aws kendra batch-put-document --index-id "10c7ac35-6c65-48f0-9c03-5bfcf58d288d" \
    --role-arn "arn:aws:iam::973830535680:role/AJKendraRoleForGettingStartedDataSource" --documents '
    [
        {
            "Id": "'"$1"'",
            "Title": "'"$1"'",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "'"Data/$1"'"
            },
            '"$ATTRIBUTES"',
            '"$ACCESSCTRLLIST"'
        }
    ]
'