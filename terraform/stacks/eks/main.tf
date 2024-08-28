terraform {
  backend "s3" {}
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "demo-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

