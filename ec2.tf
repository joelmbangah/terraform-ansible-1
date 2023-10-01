resource "aws_instance" "myec2" {
  ami                    = "ami-03a6eaae9938c858c"
  instance_type          = "t2.micro"
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = "ADS-KEYS"

  tags = {
    name = "testec2"
  }

  provisioner "remote-exec" {
  inline = [
    "sudo mkdir -p /etc/ansible",
  ]
}

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} >> /etc/ansible/hosts"
  }
}
