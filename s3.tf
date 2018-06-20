resource "aws_s3_bucket" "b" {
  bucket = "${var.BUCKET_NAME}"
  acl    = "private"
  
  versioning {
    enabled = true
  }
	
  tags {
    Name        = "Usage"
    Environment = "Logs"
  }
   
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "MyS3Policy",
  "Statement": [
	{
		"Effect": "Allow",
		"Principal": {
			"Service": "logs.${var.AWS_REGION}.amazonaws.com"
		},
		"Action": "s3:GetBucketAcl",
		"Resource": "arn:aws:s3:::${var.BUCKET_NAME}"
	},
	{
		"Effect": "Allow",
		"Principal": {
			"Service": "logs.${var.AWS_REGION}.amazonaws.com"
		},
		"Action": "s3:PutObject",
		"Resource": "arn:aws:s3:::${var.BUCKET_NAME}/*",
		"Condition": {
			"StringEquals": {
				"s3:x-amz-acl": "bucket-owner-full-control"
			}
		}
	}
	]
}
POLICY
}