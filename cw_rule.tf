resource "aws_cloudwatch_event_rule" "copy_log" {
  name        = "${var.CW_RULE_NAME}"
  description = "Launch Lambda to copy cloudwatch logs to s3"
  schedule_expression = "cron(00 02 * * ? *)"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda_function.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "arn:aws:events:${var.AWS_REGION}:${var.ACCOUNT_ID}:rule/${var.CW_RULE_NAME}"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = "${aws_cloudwatch_event_rule.copy_log.name}"
  target_id = "SendToLambda"
  arn       = "arn:aws:lambda:${var.AWS_REGION}:${var.ACCOUNT_ID}:function:lambda_function"
}