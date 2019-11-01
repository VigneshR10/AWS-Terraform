
terraform {
  backend "s3" {
    bucket = "projectX-test-tfstate"
    key="projectX/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "projectX-tfstate"
    encrypt = true
  }
}
