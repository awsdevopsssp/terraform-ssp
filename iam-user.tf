resource "aws_iam_user" "lb" {
  name = "gopi"

  tags = {
    tag-key = "devops"
  }
}

resource "aws_iam_access_key" "lb" {
  user = "${aws_iam_user.lb.name}"
}


## Outputs ##

output "ak" {
  value = "${aws_iam_access_key.lb.id}"
}

output "sk" {
  value = "${aws_iam_access_key.lb.secret}"
}
