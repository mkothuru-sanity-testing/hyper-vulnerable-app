resource "aws_s3_bucket" "public_bucket" {
  bucket = "vuln-bucket-001"
  acl    = "public-read"
}