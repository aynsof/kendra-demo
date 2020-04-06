#/bin/bash

aws kendra batch-put-document --index-id "10c7ac35-6c65-48f0-9c03-5bfcf58d288d" --role-arn "arn:aws:iam::973830535680:role/AJKendraRoleForGettingStartedDataSource" --documents '
    [
        {
            "Id": "AWS_User_Guide_to_Financial_Services_Regulations_and_Guidelines_in_Australia.pdf",
            "Title": "AWS_User_Guide_to_Financial_Services_Regulations_and_Guidelines_in_Australia.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/AWS_User_Guide_to_Financial_Services_Regulations_and_Guidelines_in_Australia.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "Technical Guide"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "AWS_Well-Architected_Framework.pdf",
            "Title": "AWS_Well-Architected_Framework.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/AWS_Well-Architected_Framework.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "White Paper"
                    }
                }
            ],
            "ContentType": "PDF"
        },{
            "Id": "Deep_Learning_on_AWS.pdf",
            "Title": "Deep_Learning_on_AWS.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/Deep_Learning_on_AWS.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "Technical Guide"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "Intro_to_AWS_Security.pdf",
            "Title": "Intro_to_AWS_Security.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/Intro_to_AWS_Security.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "White Paper"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "aws-overview.pdf",
            "Title": "aws-overview.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/aws-overview.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "White Paper"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "modern-application-development-on-aws.pdf",
            "Title": "modern-application-development-on-aws.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/modern-application-development-on-aws.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "White Paper"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "scale-out-computing-aws-ra.pdf",
            "Title": "scale-out-computing-aws-ra.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/scale-out-computing-aws-ra.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "Reference Architecture"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "snowball-edge-data-migration-guide.pdf",
            "Title": "snowball-edge-data-migration-guide.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/snowball-edge-data-migration-guide.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "Reference Architecture"
                    }
                }
            ],
            "ContentType": "PDF"
        },
        {
            "Id": "vmware-hybrid-cloud-mgmt-aws-systems-manager.pdf",
            "Title": "vmware-hybrid-cloud-mgmt-aws-systems-manager.pdf",
            "S3Path": {
                "Bucket": "t1-kendra-poc-001",
                "Key": "Data/AWS/vmware-hybrid-cloud-mgmt-aws-systems-manager.pdf"
            },
            "Attributes": [
                {
                    "Key": "DocumentType",
                    "Value": {
                        "StringValue": "Technical Reference"
                    }
                }
            ],
            "ContentType": "PDF"
        }
        
    ]
'