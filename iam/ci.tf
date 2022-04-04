data "aws_iam_policy_document" "test_essentials" {
  statement {
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAvailabilityZones"
    ]

    resources = ["*"]
  }
}
resource "aws_iam_user" "ci_runner" {
  name = "CIRunner"
  path = "/tools/"
}

resource "aws_iam_access_key" "ci_runner" {
  user = aws_iam_user.ci_runner.name
}

resource "aws_iam_user_policy" "ci_test_essentials" {
  name   = "TestEssentials"
  user   = aws_iam_user.ci_runner.name
  policy = data.aws_iam_policy_document.test_essentials.json
}
