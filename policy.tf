resource "aws_iam_policy" "lambda_export_policy" {
  name        = "lambda_export_policy"
  path        = "/"
  description = "My lambda_export_policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sns:Publish",
            "Resource": "arn:aws:sns:${var.AWS_REGION}:${var.ACCOUNT_ID}:${var.SNS_TOPIC}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateExportTask",
                "logs:DescribeExportTasks",
                "logs:DescribeLogGroups"
            ],
            "Resource": "arn:aws:logs:${var.AWS_REGION}:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        }
    ]
}
EOF
}