output "testvpcid" {
  value = "${module.test_vpc.vpcid}"
}
output "pubsub" {
  value = "${module.test_vpc.publicsubnetids}"
}
output "pubsub1" {
  value = "${module.test_vpc.publicsubnet1id}"
}
output "pubsub2" {
  value = "${module.test_vpc.publicsubnet2id}"
}
output "pubsub3" {
  value = "${module.test_vpc.publicsubnet3id}"
}
output "sgid1" {
  value = "${module.test_vpc.sgid}"
}
