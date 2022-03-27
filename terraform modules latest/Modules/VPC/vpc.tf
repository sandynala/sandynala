resource "aws_vpc" "myVPC" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = "true"
    enable_dns_support= "true"
    tags = {
      Name = "${var.vpc_name}"
    }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myVPC.id}"
  tags = {
      Name = "Igw_${var.vpc_name}"
  }
}

resource "aws_eip" "eip1" {
  vpc= "true"
  tags = {
    Name = "EIP_${var.vpc_name}"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.eip1.id}"
  subnet_id = "${aws_subnet.public_subnets.1.id}"
  tags = {
    Name = "NatGateway"
  }
}
resource "aws_security_group" "sg" {
  name = "SG_1"
  vpc_id = "${aws_vpc.myVPC.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}