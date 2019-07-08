resource "aws_instance" "ami_instance" {
  ami = "${var.ami_ID}"
  instance_type = "${var.instance_type}"
  count = 1
  key_name = "${var.key_pair}"
  provisioner "file" {
    source = "${var.startup_script}"
    destination = "/tmp/startup.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/startup.sh",
      "/tmp/startup.sh",
    ]
  }
}
##Ami creation via above mentioned instance
resource "aws_ami_from_instance" "k8s_ami" {
  name = "k8s_ami_ue1"
  description = "K8s pre setup ami bassed on ubuntu18LTS "
  source_instance_id = "${aws_instance.ami_instance.id}"
}
