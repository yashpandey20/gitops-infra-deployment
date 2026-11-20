terraform {
  backend "s3" {
    bucket  = "project18-tfstate-590507089733-1795182108"
    key     = "project18/yashpandey20/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
