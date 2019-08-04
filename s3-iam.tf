
data "aws_caller_identity" "current" { }

resource "aws_iam_user" "devopstest" {
  name = "pallavi"
}

resource "aws_iam_access_key" "devopstest" {
  user = "${aws_iam_user.devopstest.name}"
}


resource "aws_s3_bucket" "sspcloudpro_devopstest" {
  bucket = "pallavi-devops-bucket"
  acl    = "private"

    lifecycle_rule {
      id      = "remove_after_7d"
      enabled = true
      expiration {
        days = 7
      }
    }
}


resource "aws_s3_bucket_policy" "sspcloudpro_devopstest" {
  bucket = "${aws_s3_bucket.sspcloudpro_devopstest.id}"

  policy = <<POLICY
{
      "Version": "2008-10-17",
      "Statement": [
          {
              "Sid": "AddPerm",
              "Effect": "Allow",
              "Principal": {
                  "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.devopstest.name}"
              },
              "Action": [
                  "s3:ListBucket",
                  "s3:GetBucketLocation"
              ],
              "Resource": "arn:aws:s3:::pallavi-devops-bucket"
          },
          {
              "Sid": "AddPerm",
              "Effect": "Allow",
              "Principal": {
                  "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.devopstest.name}"
              },
              "Action": [
                  "s3:GetObject*",
                  "s3:PutObject*",
          "s3:DeleteObject*"
              ],
              "Resource": "arn:aws:s3:::pallavi-devops-bucket/*"
          }
      ]
}
POLICY
}


## Outputs ##

output "ak" {
  value = "${aws_iam_access_key.devopstest.id}"
}

output "sk" {
  value = "${aws_iam_access_key.devopstest.secret}"
}

