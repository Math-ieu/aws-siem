output "wazuh_server_public_ip" {
  value = aws_instance.wazuh_server.public_ip
}

output "linux_client_public_ip" {
  value = aws_instance.linux_client.public_ip
}

output "windows_client_public_ip" {
  value = aws_instance.windows_client.public_ip
}
