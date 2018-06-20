terraform {
  backend "s3" {
    bucket = "myterraform-state-dm"
    key    = "terraform_template_copylogs"
	region = "eu-west-1"
  }
}
