resource "aws_vpc" "dev_vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = "true"
  tags {
    Name = "${var.vpc_name}"
  }
}
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  tags {
    Name = "${var.vpc_igw}"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_igw.id}"
  }
  tags {
    Name = "${var.public_rt}"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  tags {
    Name = "${var.private_rt}"
  }
}

resource "aws_subnet" "pub_sub" {
  cidr_block = "${var.pub_sub_cidr}"
  vpc_id = "${aws_vpc.dev_vpc.id}"
}
resource "aws_subnet" "priv_sub" {
  cidr_block = "${var.priv_sub_cidr}"
  vpc_id = "${aws_vpc.dev_vpc.id}"
}
resource "aws_route_table_association" "pub_rt_ass" {
  route_table_id = "${aws_route_table.public_rt.id}"
  subnet_id = "${aws_subnet.pub_sub.id}"
}
resource "aws_route_table_association" "priv_rt_ass" {
  route_table_id = "${aws_route_table.private_rt.id}"
  subnet_id = "${aws_subnet.priv_sub.id}"
}
resource "aws_security_group" "pub_sec_grp" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  ingress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    protocol = "TCP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = -1
    protocol = "ICMP"
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 3306
    protocol = "TCP"
    to_port = 3306
    cidr_blocks = ["${var.cidr}"]
  }
}
resource "aws_security_group" "priv_sec_grp" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    security_groups = ["${var.pub_sub_cidr}"]
  }
  ingress {
    from_port = 6443
    protocol = "TCP"
    to_port = 6443
    security_groups = ["${var.priv_sub_cidr}"]
  }
  egress {
    from_port = 443
    protocol = "TCP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}