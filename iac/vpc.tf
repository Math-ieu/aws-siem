resource "aws_vpc" "wazuh_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "wazuh-vpc"
  }
}

resource "aws_subnet" "wazuh_subnet" {
  vpc_id                  = aws_vpc.wazuh_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"

  tags = {
    Name = "wazuh-subnet"
  }
}

resource "aws_internet_gateway" "wazuh_igw" {
  vpc_id = aws_vpc.wazuh_vpc.id

  tags = {
    Name = "wazuh-igw"
  }
}

resource "aws_route_table" "wazuh_rt" {
  vpc_id = aws_vpc.wazuh_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wazuh_igw.id
  }

  tags = {
    Name = "wazuh-rt"
  }
}

resource "aws_route_table_association" "wazuh_rta" {
  subnet_id      = aws_subnet.wazuh_subnet.id
  route_table_id = aws_route_table.wazuh_rt.id
}
