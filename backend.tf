terraform {
  backend "s3" {
    bucket         = "wu-statefiles"   
    key            = "terraform/terraform.tfstate" 
    region         = "us-east-1"
    encrypt        = true
  }
}