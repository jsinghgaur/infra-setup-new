# create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support

  tags      = {
    Name                  = "${var.project_name}-vpc"
    environment           = var.environment
    created_with          = "Terraform"
    Date_of_Creation      = var.Date_of_Creation
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name                = "${var.project_name}-igw"
    created_with        = "Terraform"
    Date_of_Creation    = var.Date_of_Creation
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name                                            = "public subnet az1"
    created_with                                    = "Terraform"
    Date_of_Creation                                = var.Date_of_Creation
  }
}

# create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name                                            = "public subnet az2"
    created_with                                    = "Terraform"
    Date_of_Creation                                = var.Date_of_Creation
  }
}


# create public subnet az3
resource "aws_subnet" "public_subnet_az3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az3_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch = true

  tags      = {
    Name                                            = "public subnet az3"
    created_with                                    = "Terraform"
    Date_of_Creation                                = var.Date_of_Creation
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name               = "public route table"
    created_with       = "Terraform"
    Date_of_Creation   = var.Date_of_Creation
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az3 to "public route table"
resource "aws_route_table_association" "public_subnet_az3_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az3.id
  route_table_id      = aws_route_table.public_route_table.id
}

# create private subnet az1
resource "aws_subnet" "private_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name                                            = "private subnet az1"
    created_with                                    = "Terraform"
    Date_of_Creation                                = var.Date_of_Creation
  }
}

# create private subnet az2
resource "aws_subnet" "private_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name                                            = "private subnet az2"
    created_with                                    = "Terraform"
    Date_of_Creation                                = var.Date_of_Creation
  }
}

# create private subnet az3
resource "aws_subnet" "private_subnet_az3" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_az3_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch  = false

  tags      = {
    Name                                            = "private subnet az3"
    created_with                                    = "Terraform"
    Date_of_Creation                                = var.Date_of_Creation
  }
}

# create elastic ip for each nat gateway
resource "aws_eip" "nat_eip-1" {
  domain = "vpc"

  tags = {
    Name                = "natgw-AZ1-eip"
    created_with        = "Terraform"
    Date_of_Creation    = var.Date_of_Creation
  }
}

resource "aws_eip" "nat_eip-2" {
  domain   = "vpc"

  tags = {
    Name                 = "natgw-AZ2-eip"
    created_with         = "Terraform"
    Date_of_Creation     = var.Date_of_Creation
  }
}

resource "aws_eip" "nat_eip-3" {
  domain = "vpc"

  tags = {
    Name                 = "natgw-AZ3-eip"
    created_with         = "Terraform"
    Date_of_Creation     = var.Date_of_Creation
  }
}

# create NAT gateway in each public subnet
resource "aws_nat_gateway" "natgw-AZ1" {
  allocation_id    = aws_eip.nat_eip-1.id # Associate the EIP with the NAT Gateway
  subnet_id        = aws_subnet.public_subnet_az1.id  # Specify the subnet ID where the NAT Gateway should reside

  tags = {
    Name                = "natgw-AZ1"
    created_with        = "Terraform"
    Date_of_Creation    = var.Date_of_Creation
}
}

resource "aws_nat_gateway" "natgw-AZ2" {
  allocation_id    = aws_eip.nat_eip-2.id  # Associate the EIP with the NAT Gateway
  subnet_id        = aws_subnet.public_subnet_az2.id  # Specify the subnet ID where the NAT Gateway should reside

  tags = {
    Name                 = "natgw-AZ2"
    created_with         = "Terraform"
    Date_of_Creation     = var.Date_of_Creation
  }
}

resource "aws_nat_gateway" "natgw-AZ3" {
  allocation_id = aws_eip.nat_eip-3.id  # Associate the EIP with the NAT Gateway
  subnet_id     = aws_subnet.public_subnet_az3.id # Specify the subnet ID where the NAT Gateway should reside

  tags = {
    Name                = "natgw-AZ3"
    created_with        = "Terraform"
    Date_of_Creation    = var.Date_of_Creation
  }
}

# Create  3 Private Route Table, one in each AZ and associate them with corresponding private subnets
#Private Route Table creation(having path for NAT-GW to provide internet access to private subnet)
resource "aws_route_table" "pri-rt-AZ1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw-AZ1.id
  }
  route {
    cidr_block = var.vpc_cidr  # Replace with your VPC CIDR block
    gateway_id = "local"    
  }

  tags = {
    Name                 = "private-rt-AZ1"
    created_with         = "Terraform"
    Date_of_Creation     = var.Date_of_Creation
  }
}

#route table association of private route table with private subnets
resource "aws_route_table_association" "pri-rt-a1" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.pri-rt-AZ1.id
}

resource "aws_route_table" "pri-rt-AZ2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw-AZ2.id
  }
  route {
    cidr_block = var.vpc_cidr  # Replace with your VPC CIDR block
    gateway_id = "local"    
  }

  tags = {
    Name                 = "private-rt-AZ2"
    created_with         = "Terraform"
    Date_of_Creation     = var.Date_of_Creation
  }
}

#route table association of private route table with private subnets
resource "aws_route_table_association" "pri-rt-a2" {
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.pri-rt-AZ2.id
} 

resource "aws_route_table" "pri-rt-AZ3" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw-AZ3.id
  }
  route {
    cidr_block = var.vpc_cidr # Replace with your VPC CIDR block
    gateway_id = "local"    
  }

  tags = {
    Name                 = "private-rt-AZ3"
    created_with         = "Terraform"
    Date_of_Creation     = var.Date_of_Creation
  }
}

#route table association of private route table with private subnets
resource "aws_route_table_association" "pri-rt-a3" {
  subnet_id      = aws_subnet.private_subnet_az3.id
  route_table_id = aws_route_table.pri-rt-AZ3.id
}


