resource "aws_instance" "web1" {
    count = "${var.machinecount}"
    ami = "${var.ami}"
    instance_type = "${var.instancetype}"
    subnet_id = "${element(var.public_subnets,count.index)}"
    vpc_security_group_ids = ["${var.sgid}"]
    key_name = var.keyname
    associate_public_ip_address = true
    tags = {
      "Name" = "webserver_${count.index+1}"
    }
}