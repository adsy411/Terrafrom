resource "aws_instance" "master" {
  ami = "XXXXX"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.priv_sec_grp.id}"]
  subnet_id = "${aws_subnet.priv_sub.id}"
  availability_zone = "${lookup(aws_subnet.priv_sub.availability_zone)}"
  key_name = "${var.key}"
  private_ip = "10.0.10.3"
  provisioner "remote-exec" {
    inline = [
      "./script/k8s-master.sh"
    ]
  }
}
resource "aws_instance" "Node-1" {
  ami = "XXXXX"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.priv_sec_grp.id}"]
  subnet_id = "${aws_subnet.priv_sub.id}"
  availability_zone = "${lookup(aws_subnet.priv_sub.availability_zone)}"
  key_name = "${var.key}"
  private_ip = "10.0.10.4"
  provisioner "remote-exec" {
    inline = [
      "./script/node-a.sh"]
  }
}
resource "aws_instance" "Node-2" {
  ami = "XXXXX"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.priv_sec_grp.id}"]
  subnet_id = "${aws_subnet.priv_sub.id}"
  availability_zone = "${lookup(aws_subnet.priv_sub.availability_zone)}"
  key_name = "${var.key}"
  private_ip = "10.0.10.5"
  provisioner "remote-exec" {
    inline = [
      "./script/node-b.sh"
    ]
  }
}
resource "aws_instance" "BastionHost" {
  ami = "XXXXX"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.pub_sec_grp.id}"]
  subnet_id = "${aws_subnet.pub_sub.id}"
  availability_zone = "${lookup(aws_subnet.pub_sub.availability_zone)}"
  key_name = "${var.key}"
  associate_public_ip_address = ture
}