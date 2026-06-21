# 1. Create the OpsForge VPC Network
resource "aws_vpc" "opsforge_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "opsforge-vpc" }
}

# 2. Create a Public Subnet for our VM
resource "aws_subnet" "opsforge_public_subnet" {
  vpc_id                  = aws_vpc.opsforge_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = { Name = "opsforge-public-subnet" }
}

# 3. Create an Internet Gateway
resource "aws_internet_gateway" "opsforge_igw" {
  vpc_id = aws_vpc.opsforge_vpc.id
  tags = { Name = "opsforge-igw" }
}

# 4. Create a Route Table
resource "aws_route_table" "opsforge_rt" {
  vpc_id = aws_vpc.opsforge_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.opsforge_igw.id
  }
  tags = { Name = "opsforge-route-table" }
}

# 5. Associate the Route Table with our Subnet
resource "aws_route_table_association" "opsforge_rta" {
  subnet_id      = aws_subnet.opsforge_public_subnet.id
  route_table_id = aws_route_table.opsforge_rt.id
}

# 6. Security Group (Firewall)
resource "aws_security_group" "opsforge_sg" {
  name        = "opsforge-security-group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.opsforge_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 7. Inject the SSH Key
resource "aws_key_pair" "opsforge_key" {
  key_name   = "opsforge-key"
  public_key = file("./opsforge_key.pub")
}

# 8. Provision the Production EC2 Instance
resource "aws_instance" "opsforge_server" {
  ami           = "ami-04b70fa74e45c3917" 
  instance_type = "t3.micro"             
  subnet_id     = aws_subnet.opsforge_public_subnet.id
  vpc_security_group_ids = [aws_security_group.opsforge_sg.id]
  key_name      = aws_key_pair.opsforge_key.key_name

  # The Startup Automation Script (CRITICAL: ZERO Indentation)
  user_data = <<EOF
#!/bin/bash
apt-get update -y
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
docker run -d -p 80:80 nginx:latest
EOF

  tags = { Name = "opsforge-production-server" }
}

# Output the public IP address
output "server_public_ip" {
  value       = aws_instance.opsforge_server.public_ip
  description = "The public IP address of the production cloud server."
}
