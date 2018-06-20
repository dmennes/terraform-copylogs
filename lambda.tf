resource "aws_iam_role" "Role_Lamba_export_logs" {
  name = "Role_Lamba_export_logs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "lambda_function.zip"
  function_name    = "lambda_function"
  role             = "${aws_iam_role.Role_Lamba_export_logs.arn}"
  timeout		   = "60"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = "${base64sha256(file("lambda_function.zip"))}"
  runtime          = "python3.6"

  environment {
    variables = {
      LOGS_BUCKET = "${var.BUCKET_NAME}"
	  LOGS_REGION = "${var.AWS_REGION}"
      LOGS_SNS_TOPIC = "arn:aws:sns:${var.AWS_REGION}:${var.ACCOUNT_ID}:${var.SNS_TOPIC}"
    }
  }
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.Role_Lamba_export_logs.name}"]
  policy_arn = "${aws_iam_policy.lambda_export_policy.arn}"
}