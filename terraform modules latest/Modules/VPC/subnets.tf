resource "aws_subnet" "public_subnets" {
    count="${length(var.public_cidrs)}"
    cidr_block = "${element(var.public_cidrs,count.index)}"
    availability_zone = "${element(var.azs,count.index)}"
    vpc_id = "${aws_vpc.myVPC.id}"
    tags = {
        Name = "Pub_Subnet_${count.index+1}"
  }
}
resource "aws_subnet" "private_subnets" {
    count="${length(var.private_cidrs)}"
    cidr_block = "${element(var.private_cidrs,count.index)}"
    availability_zone = "${element(var.azs,count.index)}"
    vpc_id = "${aws_vpc.myVPC.id}"
    tags = {
        Name = "Private_Subnet_${count.index+1}"
  }
}