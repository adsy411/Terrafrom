provider "aws" {
  access_key = "${file("PATH TO FILE")}"
  secret_key = "${file("PATH TO FILE")}"
  region = "${var.region}"
}