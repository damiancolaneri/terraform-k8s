resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "k8s" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.medium"
  subnet_id                   = element(module.vpc.public_subnets, 0)
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  associate_public_ip_address = true

  tags = {
    Name = "k8s-${var.name}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo chown ec2-user:docker /var/run/docker.sock",
      "sudo yum install conntrack -y",
      "curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo install minikube-linux-amd64 /usr/local/bin/minikube",
      "minikube start",
      "curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl",
      "chmod +x ./kubectl",
      "mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

}

