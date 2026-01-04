resource "aws_security_group" "wazuh_server_sg" {
  name        = "wazuh-server-sg"
  description = "Security group for Wazuh Server"
  vpc_id      = aws_vpc.wazuh_vpc.id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  # Dashboard access (HTTPS)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  # Wazuh agent communication
  ingress {
    from_port       = 1514
    to_port         = 1514
    protocol        = "tcp"
    security_groups = [aws_security_group.wazuh_client_sg.id]
  }

  # Wazuh enrollment
  ingress {
    from_port       = 1515
    to_port         = 1515
    protocol        = "tcp"
    security_groups = [aws_security_group.wazuh_client_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wazuh-server-sg"
  }
}

resource "aws_security_group" "wazuh_client_sg" {
  name        = "wazuh-client-sg"
  description = "Security group for Wazuh Clients"
  vpc_id      = aws_vpc.wazuh_vpc.id

  # SSH access (for Linux client)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  # RDP access (for Windows client)
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wazuh-client-sg"
  }
}
