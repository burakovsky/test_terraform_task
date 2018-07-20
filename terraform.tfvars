    ########## General project variables ##########

aws_region = "us-west-2"

environment = "stage"

key_name = "test_key"

#public_key = "${file("/home/burakouski/.ssh/id_rsa.pub")}"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9zz4MjMWfgEorJRzd/RbuD0s/1IXceRysYYyU7DnYXJ7H+QW6J1l40sQhDYrrDosiPk6mSq78oKkIk1zAoxEk6LD9nEyke/wU/hsPpmp8wwJ3MG7cdA7JexA/BAWaAv9BRbCfZ9wFGxHYkKD2HUUiHUK86vBiXLBT8IJoQj5ppbzY6chFtkbh78XN3ARkYJK/gCXgxfmihDdwXOISvI7XKptiqo86QQdr5jn3cyjtGkxH6njENvjKw78JF6O9QupZLgf8CWHSYG7ve5tkfbvtUtZU1h3vmvE9y3xA1W3pSpotDHsx9TheZQuEXHhDzbOHjr9k1I2FetRvBf/J/ZNN burakouski@burakouski"

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


    ########## Load balancer variables ##########

elb_name = "nginx-elb"

    ########## Auto Scaling variables ##########

asg_name = "nginx-asg"

associate_public_ip = "true"

ami = "ami-28e07e50"

