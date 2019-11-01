data "template_file" "cloudformation_sns_stack" {
  template = "${file("${path.module}/template_files/cloudFormation.tpl")}"
  vars {
    display_name  = "${var.projectName}-${var.environment}-Webserver"
    subscriptions = "${join("," , formatlist("{ \"Endpoint\": \"%s\", \"Protocol\": \"%s\"  }", var.emailAddress, var.protocol))}"
  }
}
resource "aws_cloudformation_stack" "snsTopicWebserver" {
  name          = "${var.projectName}-${var.environment}-webserversns"
  template_body = "${data.template_file.cloudformation_sns_stack.rendered}"
  tags = "${merge(
    map("Name", "${var.projectName}-${var.environment}")
  )}"
}

data "template_file" "userDataWebserver" {
  template = "${file("${path.module}/template_files/userDataWebserver.sh")}"
}
