# Terraform test task.

### Must be created:

  - A new VPC in us-west-2
  - A private S3 bucket
  - An autoscaling group with 3 Nginx servers. Each should have access to the S3 bucket.
*** 
### Results:
*Next terraform modules were created:*
- [VPC](https://github.com/burakovsky/test_terraform_task/tree/master/modules/network)
- [AutoScaling Group](https://github.com/burakovsky/test_terraform_task/tree/master/modules/asg)
- [Load Balancer](https://github.com/burakovsky/test_terraform_task/tree/master/modules/elb)
- [Key Pair](https://github.com/burakovsky/test_terraform_task/tree/master/modules/key_pair) (for providing ssh access to ec2 instances)
- [Security Group](https://github.com/burakovsky/test_terraform_task/tree/master/modules/security_group)
- [S3 bucket](https://github.com/burakovsky/test_terraform_task/tree/master/modules/s3_bucket)
***

### Links for checking results:
[Load Balancer](http://nginx-elb-1863557859.us-west-2.elb.amazonaws.com)
***
Use `terraform.tfvars` file for changing resource parameters.
