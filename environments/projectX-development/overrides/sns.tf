data "template_file" "userDataWebserver" {
  template = "${file("${path.module}/template_files/userData.sh")}"
}
