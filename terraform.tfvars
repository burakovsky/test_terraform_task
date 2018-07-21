    ########## General project variables ##########

aws_region = "us-west-2"

environment = "stage"

key_name = "test_key"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDC01GHV0KTKo5/Mf4La+doqXaMpiG7XWpldln0siVTV/yODXMl/V9P2ZlqtdXQMGamsu65uJDBw8rm4phqjmucUHReWgPW0i/MCVhljGSiGGZBIskbPkiCO+tdTmCmKS0xSyNm34FsPuhhqtbyZ1cLF8kDBrb/ibhCnyRY6/wQ738D33pYmtuNHIFYS9Je4tScCvFlksHoMFW/+zNHstZNA3hxh4VwY7VrdFndO+e8y3/eka97DevO2c8TZ76dz9BLb75ZzXMtsKZLAystcMm4DbxHfK4YOn6qLLNEFxTvLGln0Y9uosXBgja1x2FV988Q6eMgf2ZVtIMHKHs1s07P"
    
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

ami = "ami-ba602bc2"

    ########## S3 bucket variables ##########

bucket_name = "oxagile-maksim-bucket"

