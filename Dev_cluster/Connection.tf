provider "aws" {
  access_key = "${file("PATH TO KEY FILE")}"
  secret_key = "${file("PATH TO SECRET FILE")}"
  region = "${var.region}"
}