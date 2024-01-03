resource "aws_ecr_repository" "cbnt_app" {
  name = "${var.app_name}"
}
