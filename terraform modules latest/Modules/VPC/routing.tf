resource "aws_route_table" "rt" {
    vpc_id = "${aws_vpc.myVPC.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
      }
    tags = {
        Name = "Public_RouteTable"
        }
}
resource "aws_route_table_association" "rta" {
    count="${length(var.public_cidrs)}"
    subnet_id  = "${element(aws_subnet.public_subnets.*.id,count.index)}"
    route_table_id = "${aws_route_table.rt.id}"
}
resource "aws_route_table" "private_rt" {
    vpc_id = "${aws_vpc.myVPC.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.nat.id}"
      }
    tags = {
        Name = "Private_RouteTable"
        }
}
resource "aws_route_table_association" "private_rta" {
    count="${length(var.private_cidrs)}"
    subnet_id  = "${element(aws_subnet.private_subnets.*.id,count.index)}"
    route_table_id = "${aws_route_table.private_rt.id}"
}