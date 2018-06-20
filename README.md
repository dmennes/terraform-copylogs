# terraform-copylogs

The goal of this terraform is to deploy a Lambda function that will be triggered by a CloudWatch Event Rule to save cloudwatch logs to a S3 bucket.


Here are the variables to complete in you terraform.tfvars

AWS_ACCESS_KEY             = ""
AWS_SECRET_KEY             = ""
AWS_REGION				   = ""

BUCKET_NAME                = ""
SNS_TOPIC                  = ""
ACCOUNT_ID				   = ""

CW_RULE_NAME			   = ""