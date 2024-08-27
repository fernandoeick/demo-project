terraform {
  backend "s3" {
    bucket  = "eickhoff-tf-backend"
    key     = "sandbox/state/sandbox.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "demo-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

