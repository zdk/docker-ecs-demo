data "template_file" "cbnt-demo-app-task-definition-template" {
  template               = "${file("templates/app.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.cbnt_app.repository_url}", "https://", "")}"
  }
}

resource "aws_ecs_task_definition" "cbnt-demo-app-task-definition" {
  family                = "cbnt-demo-app"
  container_definitions = "${data.template_file.cbnt-demo-app-task-definition-template.rendered}"
}

resource "aws_elb" "cbnt-demo-app-elb" {
  name = "cbnt-demo-app-elb"

  listener {
    instance_port = 3000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 30
    target = "HTTP:3000/"
    interval = 60
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  subnets = ["${aws_subnet.main-public-1.id}","${aws_subnet.main-public-2.id}"]
  security_groups = ["${aws_security_group.cbnt-demo-app-elb-securitygroup.id}"]

  tags {
    Name = "cbnt-demo-app-elb"
  }
}

resource "aws_ecs_service" "cbnt-demo-app-service" {
  name = "cbnt-demo-app"
  cluster = "${aws_ecs_cluster.cbnt-demo-cluster.id}"
  task_definition = "${aws_ecs_task_definition.cbnt-demo-app-task-definition.arn}"
  desired_count = 2
  iam_role = "${aws_iam_role.ecs-service-role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs-service-attach1"]

  load_balancer {
    elb_name = "${aws_elb.cbnt-demo-app-elb.name}"
    container_name = "cbnt-demo-app"
    container_port = 3000
  }
  lifecycle { ignore_changes = ["task_definition"] }
}

