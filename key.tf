resource "aws_key_pair" "deployer" {
  key_name = "deployer"
  public_key = "${file("${var.path_to_public_key}")}"
  lifecycle {
    ignore_changes = ["public_key"]
  }
}
