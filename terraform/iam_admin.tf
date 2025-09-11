resource "aws_iam_user" "admin_user" {
  name = "insecure-admin"
}

resource "aws_iam_user_policy" "admin_policy" {
  user = aws_iam_user.admin_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "*"
      Resource = "*"
    }]
  })
}