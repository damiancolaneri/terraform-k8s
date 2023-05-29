output "k8s_ip" {
  value = aws_instance.k8s.public_ip
}
