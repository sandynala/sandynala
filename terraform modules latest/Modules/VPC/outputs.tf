output "vpcid" {
  value = "${aws_vpc.myVPC.id}"
}
output "publicsubnetids" {
  value = "${aws_subnet.public_subnets.*.id}"
}
output "publicsubnet1id" {
  value = "${aws_subnet.public_subnets.0.id}"
}
output "publicsubnet2id" {
  value = "${aws_subnet.public_subnets.1.id}"
}
output "publicsubnet3id" {
  value = "${aws_subnet.public_subnets.2.id}"
}
output "sgid" {
  value = "${aws_security_group.sg.id}"
}
