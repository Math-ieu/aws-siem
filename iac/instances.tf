data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["801119661308"] # Microsoft

  filter {
    name   = "name"
    values = ["Windows_Server-2025-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "wazuh_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.wazuh_subnet.id
  vpc_security_group_ids = [aws_security_group.wazuh_server_sg.id]

  root_block_device {
    volume_size = 150
    volume_type = "gp3"
  }

  tags = {
    Name = "Wazuh-Server"
  }
}

resource "aws_instance" "linux_client" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.wazuh_subnet.id
  vpc_security_group_ids = [aws_security_group.wazuh_client_sg.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "Linux-Client"
  }
}

resource "aws_instance" "windows_client" {
  ami           = data.aws_ami.windows.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.wazuh_subnet.id
  vpc_security_group_ids = [aws_security_group.wazuh_client_sg.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "Windows-Client"
  }
}
