# vpc

resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# internet Gateway

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}



# public subnets

resource "aws_subnet" "alb_subnet_public" {

  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${count.index}"
  }
}

# web private subnets

resource "aws_subnet" "web_private" {

  count = length(var.web_private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.project_name}-web-private-${count.index}"
  }
}

# app private subnets

resource "aws_subnet" "app_private" {

  count = length(var.app_private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.project_name}-app-private-${count.index}"
  }
}

# db-private-subnets

resource "aws_subnet" "db_private" {

  count = length(var.db_private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.project_name}-db-private-${count.index}"
  }
}


# elastic ip for NAT 

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.alb_subnet_public[0].id

  tags = {
    Name = "${var.project_name}-nat"
  }
}

# public route table 

resource "aws_route_table" "alb_public_rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-alb-public-rt"
  }
}

# web private route table 

resource "aws_route_table" "web_private_rt" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-web-private-rt"
  }
}

# app private route table 

resource "aws_route_table" "app_private_rt" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-app-private-rt"
  }
}

# db private route table 

resource "aws_route_table" "db_private_rt" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-db-private-rt"
  }
}

# Associate public subnets

resource "aws_route_table_association" "alb_public_assoc" {

  count = length(var.public_subnets)

  subnet_id      = aws_subnet.alb_subnet_public[count.index].id
  route_table_id = aws_route_table.alb_public_rt.id
}

# Associate Web Private Subnets

resource "aws_route_table_association" "web_assoc" {

  count = length(var.web_private_subnets)

  subnet_id      = aws_subnet.web_private[count.index].id
  route_table_id = aws_route_table.web_private_rt.id
}

# Associate App Private Subnets

resource "aws_route_table_association" "app_assoc" {

  count = length(var.app_private_subnets)

  subnet_id      = aws_subnet.app_private[count.index].id
  route_table_id = aws_route_table.app_private_rt.id
}

# Associate DB Private Subnets

resource "aws_route_table_association" "db_assoc" {

  count = length(var.db_private_subnets)

  subnet_id      = aws_subnet.db_private[count.index].id
  route_table_id = aws_route_table.db_private_rt.id
}



resource "aws_route" "web_rt_ass_private" {
  route_table_id         = aws_route_table.web_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [aws_eip.nat_eip]
}

resource "aws_route" "app_rt_ass_private" {
  route_table_id         = aws_route_table.app_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [aws_eip.nat_eip]
}

resource "aws_route" "db_rt_ass_private" {
  route_table_id         = aws_route_table.db_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [aws_eip.nat_eip]
}

