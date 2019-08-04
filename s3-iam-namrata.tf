

resource "aws_iam_user" "devopstest_namrata" {
  name = "namrata"
}

resource "aws_iam_access_key" "devopstest_namrata" {
  user = "${aws_iam_user.devopstest_namrata.name}"
}


resource "aws_s3_bucket" "sspcloudpro_devopstest_namrata" {
  bucket = "namrata-devops-bucket"
  acl    = "private"

    lifecycle_rule {
      id      = "remove_after_7d"
      enabled = true
      expiration {
        days = 7
      }
    }
}


resource "aws_s3_bucket_policy" "sspcloudpro_devopstest_namrata" {
  bucket = "${aws_s3_bucket.sspcloudpro_devopstest_namrata.id}"

  policy = <<POLICY
{
      "Version": "2008-10-17",
      "Statement": [
          {
              "Sid": "AddPerm",
              "Effect": "Allow",
              "Principal": {
                  "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.devopstest_namrata.name}"
              },
              "Action": [
                  "s3:ListBucket",
                  "s3:GetBucketLocation"
              ],
              "Resource": "arn:aws:s3:::namrata-devops-bucket"
          },
          {
              "Sid": "AddPerm",
              "Effect": "Allow",
              "Principal": {
                  "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.devopstest_namrata.name}"
              },
              "Action": [
                  "s3:GetObject*",
                  "s3:PutObject*",
          "s3:DeleteObject*"
              ],
              "Resource": "arn:aws:s3:::namrata-devops-bucket/*"
          }
      ]
}
POLICY
}


## Outputs ##

output "ak-key" {
  value = "${aws_iam_access_key.devopstest_namrata.id}"
}

output "sk-key" {
  value = "${aws_iam_access_key.devopstest_namrata.secret}"
}

