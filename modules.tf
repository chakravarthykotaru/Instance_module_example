module "newinstance" {
  source = "./instance"
  key_name = "${aws_key_pair.mykey.key_name}"
  key_path = "${var.PATH_TO_PRIVATE_KEY}"
  region = "${var.AWS_REGION}"
}
output "consul-output" {
  value = "${module.newinstance.server_address}"
}
