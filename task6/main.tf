provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  
  # Redirect requests to LocalStack
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }
}
# 1. Create the Network (VPC)
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "Production-VPC"
  }
}

# 2. Create a Subnet (The Neighborhood)
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public-Subnet"
  }
}

# 3. Create the Server (EC2 Instance)
resource "aws_instance" "my_server" {
  ami           = "ami-12345678"          # Fake Image ID (LocalStack accepts anything)
  instance_type = "m5.large"              # Smallest server size <- (it is changed from t2.micro to m5.large)
  subnet_id     = aws_subnet.my_subnet.id # Put it in our new subnet

  tags = {
    Name = "Production-server-v1"
  }
}
# Output the Server ID automatically
output "server_id" {
  value = aws_instance.my_server.id
}

# Output the Private IP address automatically
output "server_ip" {
  value = aws_instance.my_server.private_ip
}
