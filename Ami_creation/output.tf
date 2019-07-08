output "ami_name" {
  value = "${aws_ami_from_instance.k8s_ami.name}"
}
output "ami_id" {
  value = "${aws_ami_from_instance.k8s_ami.id}"
}