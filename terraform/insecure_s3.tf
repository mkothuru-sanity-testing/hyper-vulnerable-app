provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "vulnerable-bucket-test"
  acl    = "public-read" # PUBLICLY EXPOSED BUCKET
}

resource "aws_s3_bucket_policy" "bad_policy" {
  bucket = aws_s3_bucket.public_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = ["s3:*"]
      Effect    = "Allow"
      Principal = "*"
      Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
    }]
  })
}
