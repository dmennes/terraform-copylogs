resource "aws_sns_topic" "export_logs" {
  name = "${var.SNS_TOPIC}"
}