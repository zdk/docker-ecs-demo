# cluster
resource "aws_ecs_cluster" "cbnt-demo-cluster" {
    name = "cbnt-demo-cluster"
}
resource "aws_launch_configuration" "ecs-cbnt-demo-launchconfig" {
  name_prefix          = "ecs-launchconfig"
  image_id             = "${lookup(var.ecs_amis, var.aws_region)}"
  instance_type        = "${var.ecs_instance_type}"
  key_name             = "${aws_key_pair.deployer.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-ec2-role.id}"
  security_groups      = ["${aws_security_group.ecs-securitygroup.id}"]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=cbnt-demo-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle              { create_before_destroy = true }
}
resource "aws_autoscaling_group" "ecs-cbnt-demo-autoscaling" {
  name                 = "ecs-cbnt-demo-autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
  launch_configuration = "${aws_launch_configuration.ecs-cbnt-demo-launchconfig.name}"
  min_size             = 2
  max_size             = 3
  tag {
      key = "Name"
      value = "ecs-ec2-container"
      propagate_at_launch = true
  }
}


