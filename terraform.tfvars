    ########## General project variables ##########

aws_region = "us-west-2"

environment = "stage"

key_name = "test_key"

public_key = "${file("/home/burakouski/.ssh/id_rsa.pub")}"

    ########## Network variables ##########

vpc_cidr = "10.0.0.0/16"

zones = ["us-west-2a", "us-west-2b"]

subnets = ["10.0.1.0/24", "10.0.2.0/24"]


    ########## Security groups variables ##########

vpc_public_sg_name = "allow-ssh"

vpc_public_ingress_port_range = [22]

vpc_private_sg_name = "allow-private-http"

vpc_private_ingress_port_range = [80]

elb_sg_name = "allow-http"

elb_ingress_port_range = [80]
