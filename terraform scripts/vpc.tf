resource "aws_vpc" "myvpc" {
  cidr_block       = "10.11.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpcname}"
  }
}

### public-subnets

resource "aws_subnet" "publicsubnets" {
 count = "${length(var.publiccidrs)}"
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${element(var.publiccidrs,count.index)}"
  availability_zone = "${element(var.azs,count.index)}"
   tags = {
    Name = "publicsubnet-${count.index+1}"
  }
}

 #### public_rout_table 

 resource "aws_route_table" "prt" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table"
  }
}
## internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "igw"
  }
}

##public_routetable_associtaion

resource "aws_route_table_association" "prta" {
  count ="${length(var.publiccidrs)}"
  subnet_id = "${element(aws_subnet.publicsubnets.*.id,count.index)}"
  route_table_id = "${aws_route_table.prt.id}"
}

## private elastic ip 

resource "aws_eip" "elasticip" {
  vpc      = true
}

##private subnets

resource "aws_subnet" "privatesubnets"{
   count = "${length(var.privatecidrs)}"
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${element(var.privatecidrs,count.index)}"
  availability_zone = "${element(var.azs,count.index)}"
  tags = {
    Name = "privatesubnet-${count.index+1}"
  }
}

##private route atble

resource "aws_route_table" "privateroute" {
vpc_id = "${aws_vpc.myvpc.id}"
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_nat_gateway.nat.id
}
tags = {
Name = "private -route-table"
}
}

##private _routetable_associtaion

resource "aws_route_table_association" "private-route-association" {
count ="${length(var.publiccidrs)}"
subnet_id = "${element(aws_subnet.privatesubnets.*.id,count.index)}"
route_table_id = "${aws_route_table.privateroute.id}"
}

## nat gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elasticip.id
  subnet_id= "${aws_subnet.publicsubnets.1.id}"
  tags = {
    Name = "gw NAT"
  }
}