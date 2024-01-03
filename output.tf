output "ecr-repository-url" {
  value = "${aws_ecr_repository.cbnt_app.repository_url}"
}

output "elb" {
  value = "${aws_elb.cbnt-demo-app-elb.dns_name}"
}
