resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod-vpc"
    }
}


resource "aws_subnet" "prod-e" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-west-2a"
    tags = {
        Name = "prod-e"
    }
}

