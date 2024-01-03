variable "aws_region" {
  default = "ap-southeast-1"
}

variable "app_name" {
	default = "cbnt-docker-demo-1"
}

variable "path_to_public_key" {
  default = "/Users/zdk/.ssh/cybernetes.co/aws/demo/deployer.pub"
}

variable "ecs_instance_type" {
  default = "t2.micro"
}

variable "ecs_amis" {
	type = "map"
	default = {
		ap-southeast-1 = "ami-091bf462afdb02c60"
	}
}
