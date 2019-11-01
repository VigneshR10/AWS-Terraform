resource "aws_key_pair" "rtMessages" {
  key_name   = "${var.projectName}-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZeQmMVdLE/S/CVh4B1E88UCRhj4UJXNApYf8cAINgy8Blc74XQZKHOt1GT3zZxBhT4X1MjVFeDHlrZ5SVCmWeocmxLo8vP1xYUKnk6QlTwnnWuA8Md/fLXcLbMK9iIPpM+RDIckKwbY4/MMR2P0HWb72bN+r+TZdx/HB5Lxhdu6HnOWq3JQzLvt0/3ejWqi9g4I6VZrBlSHxVWEaTyHS1XelgohXA08FsqiCTqHgmZwctu06x6SaSwQ4MLMfDzrp3qg3u5szlZZbY7g+rRON0zfvrawR4A8pzBjcTn+n9jspmqTYey6naXitX4rsVCRZiPkrBfN6vKOH6Mop+KjuP ubuntu"
}
